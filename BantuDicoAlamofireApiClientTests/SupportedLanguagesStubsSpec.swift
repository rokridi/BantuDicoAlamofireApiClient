//
//  SupportedLanguagesStubsSpec.swift
//  BantuDicoAlamofireApiClientTests
//
//  Created by Mohamed Aymen Landolsi on 29/01/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import OHHTTPStubs

@testable import BantuDicoAlamofireApiClient

class SupportedLanguagesStubsSpec: QuickSpec {
    
    override func spec() {
        
        describe("Fetch supported languages") {
            
            var apiClient: BantuDicoAlamofireApiClient!
            
            beforeEach {
                apiClient = BantuDicoAlamofireApiClient(baseURL: "https://google.fr")
            }
            
            afterEach {
                apiClient = nil
            }
            
            context("Everything goes fine", {
                
                it("Should return a valid result", closure: {
                    stub(condition: isHost("google.fr")) { request in
                        return OHHTTPStubsResponse(
                            fileAtPath: OHPathForFile("supported_languages.json", type(of: self))!,
                            statusCode: 200,
                            headers: ["Content-Type":"application/json"]
                        )
                    }
                    
                    waitUntil(action: { done in
                        let _ = apiClient.fetchSupportedLanguages(completion: { (bdLanguages, error) in
                            
                            let identifiers = TestsHelper.bantuDicoLanguagesFromJSONFile("supported_languages").map({$0.identifier})
                            let receivedIdentifiers = bdLanguages!.map({ $0.identifier })
                            expect(identifiers).to(equal(receivedIdentifiers))
                            done()
                        })
                    })
                })
            })
            
            context("Unecceptable status code", {
                it("Returns roor code 400", closure: {
                    
                    let unacceptableStatusCode400Error = BantuDicoAFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 400))
                    
                    stub(condition: isHost("google.fr")) { request in
                        return OHHTTPStubsResponse(error: unacceptableStatusCode400Error)
                    }
                    
                    waitUntil(action: { done in
                        let _ = apiClient.fetchSupportedLanguages(completion: { (_, error) in
                            
                            if case BantuDicoAFError.responseValidationFailed(reason: .unacceptableStatusCode(code: let code)) = error as! BantuDicoAFError {
                                expect(unacceptableStatusCode400Error.responseCode).to(equal(code))
                            } else {
                                fail("Reason should be of type unacceptableContentType with code 400")
                            }
                            
                            done()
                        })
                    })
                })
                
                it("Returns roor code 404", closure: {
                    
                    let unacceptableStatusCode400Error = BantuDicoAFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 404))
                    
                    stub(condition: isHost("google.fr")) { request in
                        return OHHTTPStubsResponse(error: unacceptableStatusCode400Error)
                    }
                    
                    waitUntil(action: { done in
                        let _ = apiClient.fetchSupportedLanguages(completion: { (_, error) in
                            
                            if case BantuDicoAFError.responseValidationFailed(reason: .unacceptableStatusCode(code: let code)) = error as! BantuDicoAFError {
                                expect(unacceptableStatusCode400Error.responseCode).to(equal(code))
                            } else {
                                fail("Reason should be of type unacceptableContentType with code 404.")
                            }
                            
                            done()
                        })
                    })
                })
                
                it("Returns error code 500", closure: {
                    
                    TestsHelper.stubWithHost("", httpCode: 500)
                    
                    waitUntil(action: { done in
                        let _ = apiClient.fetchSupportedLanguages(completion: { (_, error) in
                            
                            if case BantuDicoAFError.responseValidationFailed(reason: .unacceptableStatusCode(code: let code)) = error as! BantuDicoAFError {
                                expect(code).to(equal(500))
                            } else {
                                fail("Reason should be of type unacceptableContentType with code 500")
                            }
                            
                            done()
                        })
                    })
                })
            })
            
            context("Unecceptable response content type", {
                it("Error should be unacceptableContentType", closure: {
                    
                    let contentTypeError = BantuDicoAFError.responseValidationFailed(reason: .unacceptableContentType(acceptableContentTypes: ["JSON"], responseContentType: "XML"))
                    
                    stub(condition: {_ in true}) { request in
                        return OHHTTPStubsResponse(error: contentTypeError)
                    }
                    
                    waitUntil(action: { done in
                        let _ = apiClient.fetchSupportedLanguages(completion: { (_, error) in
                            let bdError = error as! BantuDicoAFError
                            
                            if case BantuDicoAFError.responseValidationFailed(reason: .unacceptableContentType(acceptableContentTypes: _, responseContentType: let responseContentType)) = bdError{
                                expect(contentTypeError.responseContentType).to(equal(responseContentType))
                            } else {
                                fail("Reason should be of type unacceptableContentType-responseValidationFailed")
                            }
                            done()
                        })
                    })
                })
            })
        }
    }
}
