//
//  TestsHelper.swift
//  BantuDicoAlamofireApiClientTests
//
//  Created by Mohamed Aymen Landolsi on 30/01/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation
import OHHTTPStubs
import ObjectMapper

@testable import BantuDicoAlamofireApiClient

class TestsHelper {
    
    static func stubWithHost(_ host: String, httpCode: Int) {
        
        stub(condition: isHost("google.fr")) { request in
            
            let error = BantuDicoAFError.responseValidationFailed(reason: .unacceptableStatusCode(code: httpCode))
            return OHHTTPStubsResponse(error: error)
        }
    }
    static func JSONFromFile(_ file: String) -> [String: Any]? {
        
        let bundle = Bundle(for: TestsHelper.self)
        let file = bundle.url(forResource: file, withExtension: "json")!
        
        do {
            let data = try Data(contentsOf: file)
            let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return dictionary as? [String : Any]
        } catch {
            return nil
        }
    }
    
    static func bantuDicoLanguagesFromJSONFile(_ file: String) -> [BantuDicoLanguage] {
        
        let dictionary = TestsHelper.JSONFromFile(file)
        
        let array = dictionary!["supported_languages"]
        
        let mapper = Mapper<BDLanguage>()
        let translations = mapper.mapArray(JSONObject: array)
        
        return translations!.map({ $0.asBantuDicoLanguage() })
    }
    
    static func bantuDicoWordsFromJSONFile(_ file: String) -> [BantuDicoWord] {
        
        let dictionary = TestsHelper.JSONFromFile(file)
        
        let array = dictionary!["translations"]
        
        let mapper = Mapper<BDWord>()
        let translations = mapper.mapArray(JSONObject: array)
        
        return translations!.map({ $0.asBantuDicoWord() })
    }
}

