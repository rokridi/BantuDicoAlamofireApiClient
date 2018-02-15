//
//  TanslationRequestsStubsSpec.swift
//  BantuDicoAlamofireApiClientTests
//
//  Created by Mohamed Aymen Landolsi on 31/01/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation
import Nimble
import Quick
import OHHTTPStubs

@testable import BantuDicoAlamofireApiClient

class TanslationRequestsStubsSpec: QuickSpec {
    
    override func spec() {
        
        var apiClient: BantuDicoAlamofireApiClient!
        
        beforeEach {
            apiClient = BantuDicoAlamofireApiClient(baseURL: "https://google.fr")
        }
        
        afterEach {
            apiClient = nil
        }
        
        describe("Translate 'Bonjour', 'Pourquoi' from 'fr' to 'sg'") {
            /*
            context("Translate 'Bonjour' from 'fr' to 'sg'", {
                
                it("Should return one word", closure: {
                    stub(condition: isHost("google.fr")) { request in
                        return OHHTTPStubsResponse(
                            fileAtPath: OHPathForFile("bonjour_fr_sg_translation.json", type(of: self))!,
                            statusCode: 200,
                            headers: ["Content-Type":"application/json"]
                        )
                    }
                    
                    waitUntil(action: { done in
                        
                        let _ = apiClient.translate(word: "Bonjour", sourceLanguage: "fr", destinationLanguage: "sg", completion: { (words, error) in
                            
                            let stubWords = TestsHelper.bantuDicoWordsFromJSONFile("bonjour_fr_sg_translation")
                            
                            expect(words!.count).to(equal(1))
                            expect(words![0].word).to(equal(stubWords[0].word))
                            done()
                        })
                    })
                })
            })*/
        }
        
        context("Translate 'Pourquoi' from 'fr' to 'sg'", {
            
            it("Should return two words", closure: {
                stub(condition: isHost("google.fr")) { request in
                    return OHHTTPStubsResponse(
                        fileAtPath: OHPathForFile("pourquoi_fr_sg_translation.json", type(of: self))!,
                        statusCode: 200,
                        headers: ["Content-Type":"application/json"]
                    )
                }
                
                waitUntil(action: { done in
                    let _ = apiClient.translate(word: "Pourquoi", sourceLanguage: "fr", destinationLanguage: "sg", completion: { (words, error) in
                        
                        let stubWords = TestsHelper.bantuDicoWordsFromJSONFile("pourquoi_fr_sg_translation")
                        
                        expect(words!.count).to(equal(2))
                        expect(words![0].word).to(equal(stubWords[0].word))
                        expect(words![1].word).to(equal(stubWords[1].word))
                        done()
                    })
                })
            })
        })
    }
}
