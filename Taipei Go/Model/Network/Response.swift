//
//  Response.swift
//  Taipei Go
//
//  Created by 洪德晟 on 31/01/2018.
//  Copyright © 2018 Dan. All rights reserved.
//

import Foundation

public struct Response: Codable {
    
    var result: Results
}

public struct Results: Codable {
    
    var results: [Result]
}

public struct Result: Codable {
    
    var stitle: String
    var xbody: String
    var file: String
}
