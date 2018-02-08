//
//  DataTaipei.swift
//  Taipei Go
//
//  Created by 洪德晟 on 31/01/2018.
//  Copyright © 2018 Dan. All rights reserved.
//

import Foundation
import Alamofire

public protocol RequestComposer {
    
    var host        : String { get }
    var method      : HTTPMethod { get }
    var path        : String { get }
    var queryItems  : [URLQueryItem]? { get }
    var parameters  : Parameters? { get }
}

public extension RequestComposer {
    
    var host: String {
        return "data.taipei"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/opendata/datalist/apiAccess"
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var parameters: Parameters? {
        return nil
    }
}

public class DataTaipei {
    
    public enum Entertainment: RequestComposer {
        
        case TouristSites(rid: String, limit: Int, offset: Int)
        
        public var queryItems: [URLQueryItem]? {
            switch self {
            case let .TouristSites(rid, limit, offset):
                let scopeQuery = URLQueryItem(name: "scope", value: "resourceAquire")
                let ridQuery = URLQueryItem(name: "rid", value: rid)
                let limitQuery = URLQueryItem(name: "limit", value: String(limit))
                let offsetQuery = URLQueryItem(name: "offset", value: String(offset))
                return [scopeQuery, ridQuery, limitQuery, offsetQuery]
            }
        }
    }
    
}
