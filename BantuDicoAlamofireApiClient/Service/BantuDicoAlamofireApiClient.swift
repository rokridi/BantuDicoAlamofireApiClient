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

typealias TranslationCompletionHandler = ([BantuDicoWord]?, Error?) -> Void
typealias SupportedLanguagesCompletionHandler = ([BantuDicoLanguage]?, Error?) -> Void

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
            .responseArray(completionHandler: { (response:DataResponse<[BDWord]>) in
                
                switch response.result {
                case .success(let translations):
                    queue?.async { completion?(translations.map({$0.asBantuDicoWord()}), nil) }
                case .failure(let error):
                    
                    var finalError: Error
                    
                    if let afError = error as? AFError {
                        finalError = afError.asBantuDicoAFError()
                    } else {
                        finalError = BantuDicoAFError.jsonMappingFailed(error: error)
                    }
                    
                    queue?.async {
                        completion?(nil, finalError)
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
            .responseArray(keyPath: "supported_languages", completionHandler: { (response:DataResponse<[BDLanguage]>) in
                
                switch response.result {
                case .success(let bdLanguages):
                    queue?.async {
                        completion?(bdLanguages.map({$0.asBantuDicoLanguage()}), nil)
                    }
                case .failure(let error):
                    var finalError: Error
                    
                    if let afError = error as? AFError {
                        finalError = afError.asBantuDicoAFError()
                    } else {
                        finalError = BantuDicoAFError.jsonMappingFailed(error: error)
                    }
                    
                    queue?.async {
                        completion?(nil, finalError)
                    }
                }
            })
        
        return dataRequest.task
    }
}
