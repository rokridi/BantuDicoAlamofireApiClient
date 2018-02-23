//
//  BDLanguageStubsSpec.swift
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

class BDLanguageStubsSpec: QuickSpec {
    
    override func spec() {
        
        describe("BDLanguage") {
            
            context("when JSON is valid", {
                
                it("should not be nil", closure: {
                    
                    let bdLanguage = try? BantuDicoAFLanguage(JSONObject: TestsHelper.JSONFromFile("valid_bdlanguage") ?? [:])
                    expect(bdLanguage).toEventuallyNot(beNil())
                })
            })
            
            context("when JSON is not valid", {
                
                it("should be nil", closure: {
                    
                    let bdLanguage = try? BantuDicoAFLanguage(JSONObject: TestsHelper.JSONFromFile("invalid_bdlanguage") ?? [:])
                    expect(bdLanguage).toEventually(beNil())
                })
            })
        }
    }
}
