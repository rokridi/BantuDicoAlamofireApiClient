//
//  BantuDicoAlamofireApiClient.swift
//  Bantu dico
//
//  Created by Mohamed Aymen Landolsi on 28/01/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

typealias TranslationCompletionHandler = ([BDAFWord]?, Error?) -> Void
typealias SupportedLanguagesCompletionHandler = ([BDAFLanguage]?, Error?) -> Void

class BantuDicoAlamofireApiClient {
    
    let baseURL: String
    private let sessionManager: SessionManager
    
    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default, baseURL: String) {
        sessionManager = SessionManager(configuration: configuration)
        self.baseURL = baseURL
    }
}

//MARK: - API

extension BantuDicoAlamofireApiClient {
    
    public func translate(word: String,
                   sourceLanguage: String,
                   destinationLanguage: String,
                   queue: DispatchQueue? = DispatchQueue.main,
                   completion: TranslationCompletionHandler?) -> URLSessionTask? {
        
        let request = BantuDicoAlamofireApiEndpoint.translate(word, sourceLanguage, destinationLanguage, baseURL)
        
        let dataRequest = sessionManager.request(request)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseArray(keyPath: "translations", completionHandler: { (response:DataResponse<[BantuDicoAFWord]>) in
                
                switch response.result {
                case .success(let translations):
                    queue?.async { completion?(translations.map({$0.asBDAFWord()}), nil) }
                case .failure(let error):
                    queue?.async {
                        completion?(nil, self.completionErrorFrom(error: error))
                    }
                }
            })
        
        return dataRequest.task
    }
    
    public func fetchSupportedLanguages(queue: DispatchQueue? = DispatchQueue.main,
                                 completion: SupportedLanguagesCompletionHandler?) -> URLSessionTask? {
        
        let request = BantuDicoAlamofireApiEndpoint.supportedLanguages(baseURL)
        
        let dataRequest = sessionManager.request(request)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseArray(keyPath: "supported_languages", completionHandler: { (response:DataResponse<[BantuDicoAFLanguage]>) in
                
                switch response.result {
                case .success(let bdLanguages):
                    queue?.async {
                        completion?(bdLanguages.map({$0.asBDAFLanguage()}), nil)
                    }
                case .failure(let error):
                    queue?.async {
                        completion?(nil, self.completionErrorFrom(error: error))
                    }
                }
            })
        
        return dataRequest.task
    }
}

private extension BantuDicoAlamofireApiClient {
    
    func completionErrorFrom(error: Error) -> Error {
        
        if let afError = error as? AFError {
            return afError.asBantuDicoAFError()
        } else {
            return BantuDicoAFError.jsonMappingFailed(error: error)
        }
    }
}
