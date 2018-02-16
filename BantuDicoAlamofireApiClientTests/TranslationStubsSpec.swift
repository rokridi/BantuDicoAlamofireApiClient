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

class TranslationStubsSpec: QuickSpec {
    
    override func spec() {
        
        describe("Translation") {
            
            context("when JSON is valid", {
                
                it("Should not be nil", closure: {
                    
                    let mapper = Mapper<BantuDicoAFWord>()
                    let dictionary = TestsHelper.JSONFromFile("valid_word_translation")!
                    let array = dictionary["translations"]
                    let translations = try? mapper.mapArray(JSONArray: array as! [[String : Any]])
                    
                    expect(translations).toNot(beNil())
                })
            })
            
            context("when JSON is not valid", {
                
                it("Should be nil", closure: {
                    
                    let mapper = Mapper<BantuDicoAFWord>()
                    let dictionary = TestsHelper.JSONFromFile("invalid_word_translation")!
                    let array = dictionary["translations"]
                    let translations = try? mapper.mapArray(JSONArray: array as! [[String : Any]])
                    
                    expect(translations).to(beNil())
                })
            })
        }
    }
}
