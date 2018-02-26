//
//  BDAFTranslation.swift
//  BantuDicoAlamofireApiClient
//
//  Created by Mohamed Aymen Landolsi on 23/02/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation

/// Reperents a result of a translation done via Bantu Dico API.
public struct BDAFTranslation {
    
    /// Translated word.
    public let word: String
    
    /// Language of the translated word.
    public let language: String
    
    /// Translation language.
    public let translationLanguage: String
    
    /// Translations of word.
    public let translations: [String]
}
