//
//  BantuDicoAFTranslation.swift
//  BantuDicoAlamofireApiClient
//
//  Created by Mohamed Aymen Landolsi on 23/02/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation
import ObjectMapper

struct BantuDicoAFTranslation: ImmutableMappable {
    
    let word: String
    let language: String
    let translationLanguage: String
    let translations: [String]
    
    init(map: Map) throws {
        word = try map.value("word")
        language = try map.value("language")
        translationLanguage = try map.value("translationLanguage")
        translations = try map.value("translations")
    }
}

extension BantuDicoAFTranslation {
    
    func asBDAFTranslation() -> BDAFTranslation {
        return BDAFTranslation(word: word, language: language, translationLanguage: translationLanguage, translations: translations)
    }
}

