//
//  BantuDicoAlamofireApiClientTests.swift
//  BantuDicoAlamofireApiClientTests
//
//  Created by Mohamed Aymen Landolsi on 29/01/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import XCTest
import Quick
import Nimble
import OHHTTPStubs

@testable import BantuDicoAlamofireApiClient

class BantuDicoAlamofireApiClientTests: QuickSpec {
    
    let baseURL = ""
    let requestTimeout = 4.0
    
    override func spec() {
        
        var bdClient: BantuDicoAlamofireApiClient!
        
        beforeEach {
            let configuration = URLSessionConfiguration()
            configuration.timeoutIntervalForRequest = self.requestTimeout
            bdClient = BantuDicoAlamofireApiClient(configuration: configuration, baseURL: self.baseURL)
        }
        
        describe("Fetch supported languages") {
            
            it("Should succeed", closure: {
                
                waitUntil(timeout: self.requestTimeout, action: { done in
                    
                    let _ = bdClient.fetchSupportedLanguages(completion: { (languages, error) in
                        expect(error).to(beNil())
                        expect(languages?.count).to(beGreaterThan(0))
                        done()
                    })
                })
            })
        }
        
        describe("Translate the word 'Bonjour' with source language 'fr' and destination language 'sg'") {
            
            it("Should succeed", closure: {
                
                waitUntil(timeout: self.requestTimeout, action: { done in
                    
                    let _ = bdClient.translate(word: "Bonjour", sourceLanguage: "fr", destinationLanguage: "sg", completion: { (words, error) in
                        
                        expect(error).to(beNil())
                        expect(words?.count).to(beGreaterThan(0))
                        done()
                    })
                })
            })
        }
        
        describe("Translate the word 'fdfdakjfdkuzygfkjzqyrfg' with source language 'fr' and destination language 'sg'") {
            
            it("Should return an empty result", closure: {
                
                waitUntil(timeout: self.requestTimeout, action: { done in
                    
                    let _ = bdClient.translate(word: "fdfdakjfdkuzygfkjzqyrfg", sourceLanguage: "fr", destinationLanguage: "sg", completion: { (words, error) in
                        
                        expect(error).to(beNil())
                        expect(words?.count).to(equal(0))
                        done()
                    })
                })
            })
        }
    }
}
