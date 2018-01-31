//
//  BantuDicoWord.swift
//  Bantu dico
//
//  Created by Mohamed Aymen Landolsi on 24/01/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation

public struct BantuDicoWord {
    
    let identifier: Int
    let word: String
    
    init(identifier: Int, word: String) {
        self.identifier = identifier
        self.word = word
    }
}
