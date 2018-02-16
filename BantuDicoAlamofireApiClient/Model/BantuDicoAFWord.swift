//
//  BantuDicoAFWord.swift
//  BantuDicoAlamofireApiClient
//
//  Created by Mohamed Aymen Landolsi on 29/01/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation
import ObjectMapper

struct BantuDicoAFWord: ImmutableMappable {
    
    let identifier: Int
    let word: String
    
    init(map: Map) throws {
        identifier = try map.value("id")
        word = try map.value("word")
    }
}

extension BantuDicoAFWord {
    
    func asBDAFWord() -> BDAFWord {
        return BDAFWord(identifier: identifier, word: word)
    }
}
