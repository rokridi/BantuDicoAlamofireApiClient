//
//  BantuDicoLanguage.swift
//  BantuDicoAlamofireApiClient
//
//  Created by Mohamed Aymen Landolsi on 29/01/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation
import ObjectMapper

struct BantuDicoAFLanguage: ImmutableMappable {
    
    let identifier: Int
    let code: String
    
    init(map: Map) throws {
        identifier = try map.value("id")
        code = try map.value("code")
    }
}

extension BantuDicoAFLanguage {
    
    func asBDAFLanguage() -> BDAFLanguage {
        return BDAFLanguage(identifier: identifier, code: code)
    }
}
