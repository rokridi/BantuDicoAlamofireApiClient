//
//  BantuDicoLanguage.swift
//  Bantu dico
//
//  Created by Mohamed Aymen Landolsi on 26/01/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation

public struct BantuDicoLanguage {
    
    let identifier: Int
    let code: String
    
    init(identifier: Int, code: String) {
        self.identifier = identifier
        self.code = code
    }
}
