//
//  TranslationStubsSpec.swift
//  BantuDicoAlamofireApiClientTests
//
//  Created by Mohamed Aymen Landolsi on 30/01/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation

import Quick
import Nimble
import ObjectMapper
import OHHTTPStubs

@testable import BantuDicoAlamofireApiClient

class ModelsSpec: QuickSpec {
    
    override func spec() {
        
        describe("Translation") {
            
            context("when JSON is valid", {
                
                it("Should not be nil", closure: {
                    
                    let mapper = Mapper<BantuDicoAFTranslation>()
                    let json = TestsHelper.JSONFromFile("valid_word_translation")!
                    let translation = try? mapper.map(JSON: json)
                    
                    expect(translation).toNot(beNil())
                })
            })
            
            context("when JSON is not valid", {
                
                it("Should be nil", closure: {
                    
                    let mapper = Mapper<BantuDicoAFTranslation>()
                    let json = TestsHelper.JSONFromFile("invalid_word_translation")
                    let translation = try? mapper.map(JSONObject: json as Any)
                    
                    expect(translation).to(beNil())
                })
            })
        }
    }
}
