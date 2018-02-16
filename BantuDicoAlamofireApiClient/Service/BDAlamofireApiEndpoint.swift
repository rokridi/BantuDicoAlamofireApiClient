//
//  BantuDicoAlamofireApiEndpoint.swift
//  Bantu dico
//
//  Created by Mohamed Aymen Landolsi on 29/01/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation
import Alamofire

enum BDAlamofireApiEndpoint: URLRequestConvertible {
    
    case translate(String, String, String, String)
    case supportedLanguages(String)
    
    private var baseURL: String {
        switch self {
        case .translate(_, _, _, let baseURL), .supportedLanguages(let baseURL):
            return baseURL
        }
    }
    
    private var path: String {
        switch self {
        case .translate(_ ,_ ,_, _):
            return ""
        case .supportedLanguages(_):
            return ""
        }
    }
    
    private var method: Alamofire.HTTPMethod {
        return .post
    }
    
    private var parameters: [String: AnyObject] {
        return ["": "" as AnyObject]
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try self.baseURL.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
