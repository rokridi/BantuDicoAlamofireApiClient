//
//  BDLanguage.swift
//  BantuDicoAlamofireApiClient
//
//  Created by Mohamed Aymen Landolsi on 29/01/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation
import ObjectMapper

struct BDLanguage: ImmutableMappable {
    
    let identifier: Int
    let code: String
    
    init(map: Map) throws {
        identifier = try map.value("id")
        code = try map.value("code")
    }
}

extension BDLanguage {
    
    func asBantuDicoLanguage() -> BantuDicoLanguage {
        return BantuDicoLanguage(identifier: identifier, code: code)
    }
}
