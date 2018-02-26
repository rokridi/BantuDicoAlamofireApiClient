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
        
        context("Translate 'hello' from 'en' to 'fr'", {
            
            it("Should return succeed", closure: {
                stub(condition: isHost("google.fr")) { request in
                    return OHHTTPStubsResponse(
                        fileAtPath: OHPathForFile("hello_en_fr_translation.json", type(of: self))!,
                        statusCode: 200,
                        headers: ["Content-Type":"application/json"]
                    )
                }
                
                waitUntil(action: { done in
                    let _ = apiClient.translate(word: "hello", sourceLanguage: "en", destinationLanguage: "fr", completion: { (translation, error) in                        
                        expect(error).to(beNil())
                        expect(translation).toNot(beNil())
                        done()
                    })
                })
            })
        })
    }
}
