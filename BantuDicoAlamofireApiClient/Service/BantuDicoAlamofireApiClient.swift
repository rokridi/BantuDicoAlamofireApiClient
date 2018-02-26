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

public typealias TranslationCompletionHandler = (BDAFTranslation?, Error?) -> Void
public typealias SupportedLanguagesCompletionHandler = ([BDAFLanguage]?, Error?) -> Void

public class BantuDicoAlamofireApiClient {
    
    private let baseURL: String
    private let sessionManager: SessionManager
    
    public init(configuration: URLSessionConfiguration = URLSessionConfiguration.default, baseURL: String) {
        sessionManager = SessionManager(configuration: configuration)
        self.baseURL = baseURL
    }
}

//MARK: - API

public extension BantuDicoAlamofireApiClient {
    
    /// Translates a word.
    ///
    /// - Parameters:
    ///   - word: the word to translate.
    ///   - sourceLanguage: the language of word.
    ///   - destinationLanguage: the language to which word will be translated.
    ///   - queue: the queue on which completion will be called when the task finishes.
    ///   - completion: closure to be called when task finishes.
    /// - Returns: URLSessionTask
    public func translate(word: String,
                   sourceLanguage: String,
                   destinationLanguage: String,
                   queue: DispatchQueue = DispatchQueue.main,
                   completion: TranslationCompletionHandler?) -> URLSessionTask? {
        
        let request = BDAlamofireApiEndpoint.translate(word, sourceLanguage, destinationLanguage, baseURL)
        
        let dataRequest = sessionManager.request(request)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseObject(completionHandler: { [weak self] (response:DataResponse<BantuDicoAFTranslation>) in
                
                switch response.result {
                case .success(let translation):
                    queue.async { completion?(translation.asBDAFTranslation(), nil) }
                case .failure(let error):
                    queue.async { completion?(nil, self?.finalErrorFrom(error: error)) }
                }
            })
        
        return dataRequest.task
    }
    
    /// Fetches languages that are supported for translation.
    ///
    /// - Parameters:
    ///   - queue: the queue on which completion will be called when the task finishes.
    ///   - completion: closure to be called when task finishes.
    /// - Returns: URLSessionTask.
    public func fetchSupportedLanguages(queue: DispatchQueue = DispatchQueue.main,
                                 completion: SupportedLanguagesCompletionHandler?) -> URLSessionTask? {
        
        let request = BDAlamofireApiEndpoint.supportedLanguages(baseURL)
        
        let dataRequest = sessionManager.request(request)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseArray(keyPath: "supported_languages", completionHandler: { [weak self] (response:DataResponse<[BantuDicoAFLanguage]>) in
                
                switch response.result {
                case .success(let bdLanguages):
                    queue.async {
                        completion?(bdLanguages.map({$0.asBDAFLanguage()}), nil)
                    }
                case .failure(let error):
                    queue.async {
                        completion?(nil, self?.finalErrorFrom(error: error))
                    }
                }
            })
        
        return dataRequest.task
    }
}

private extension BantuDicoAlamofireApiClient {
    
    func finalErrorFrom(error: Error) -> Error {
        
        if let afError = error as? AFError {
            return afError.asBantuDicoAFError()
        } else {
            return BDAFError.jsonMappingFailed(error: error)
        }
    }
}
