//
//  NetworkError.swift
//  Taipei Go
//
//  Created by 洪德晟 on 31/01/2018.
//  Copyright © 2018 Dan. All rights reserved.
//

import Foundation

public enum NetworkError: Error, CustomStringConvertible {
    
    case Connection
    case UnrecognizableResult
    case InvaidResponse(key: String)
    case JSONSerialization(element: String)
    
    public var description : String {
        switch self {
        case .Connection:
            return "Connection Timeout"
        case .UnrecognizableResult:
            return "Unrecognizable Result"
        case .InvaidResponse(let key):
            return "Invalid Response with Unrecognized Key: \"\(key)\""
        default:
            return "Some other error"
        }
    }
}
