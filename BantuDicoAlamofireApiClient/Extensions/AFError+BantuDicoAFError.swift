//
//  AFError+BantuDicoError.swift
//  BantuDicoAlamofireApiClient
//
//  Created by Mohamed Aymen Landolsi on 31/01/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation
import Alamofire

private extension AFError.ParameterEncodingFailureReason {
    
    func asBantuDicoParameterEncodingFailureReason() -> BDAFError.ParameterEncodingFailureReason {
        switch self {
        case .jsonEncodingFailed(error: let error):
            return .jsonEncodingFailed(error: error)
        case .missingURL:
            return .missingURL
        default:
            return .unknownReason
        }
    }
}

private extension AFError.ResponseSerializationFailureReason {
    
    func asResponseSerializationFailureReason() -> BDAFError.ResponseSerializationFailureReason {
        switch self {
        case .inputDataNil:
            return .inputDataNil
        case .inputDataNilOrZeroLength:
            return .inputDataNilOrZeroLength
        case .inputFileNil:
            return .inputFileNil
        case .inputFileReadFailed(at: let url):
            return .inputFileReadFailed(at: url)
        case .jsonSerializationFailed(error: let error):
            return .jsonSerializationFailed(error: error)
        default:
            return .unknownReason
        }
    }
}

private extension AFError.ResponseValidationFailureReason {
    
    func asResponseValidationFailureReason() -> BDAFError.ResponseValidationFailureReason {
        switch self {
        case .dataFileNil:
            return .dataFileNil
        case .dataFileReadFailed(at: let url):
            return .dataFileReadFailed(at: url)
        case .missingContentType(acceptableContentTypes: let contentTypes):
            return .missingContentType(acceptableContentTypes: contentTypes)
        case let .unacceptableContentType(acceptableContentTypes: contentTypes, responseContentType: contentType):
            return .unacceptableContentType(acceptableContentTypes: contentTypes, responseContentType: contentType)
        case .unacceptableStatusCode(code: let code):
            return .unacceptableStatusCode(code: code)
            
        }
    }
}

extension AFError {
    
    func asBantuDicoAFError() -> BDAFError {
        
        switch self {
        case .invalidURL(url: let urlConvertible):
            return .invalidURL(url: try? urlConvertible.asURL())
        case .parameterEncodingFailed(reason: let reason):
            return .parameterEncodingFailed(reason: reason.asBantuDicoParameterEncodingFailureReason())
        case .responseValidationFailed(reason: let reason):
            return .responseValidationFailed(reason: reason.asResponseValidationFailureReason())
        case .responseSerializationFailed(reason: let reason):
            return .responseSerializationFailed(reason: reason.asResponseSerializationFailureReason())
        default:
            return BDAFError.unknownError
        }
    }
}
