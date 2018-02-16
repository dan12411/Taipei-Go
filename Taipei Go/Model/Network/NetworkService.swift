//
//  NetworkService.swift
//  Taipei Go
//
//  Created by 洪德晟 on 31/01/2018.
//  Copyright © 2018 Dan. All rights reserved.
//

import Foundation
import Alamofire

public struct NetworkRequest {
    
    private static let sessionConfig: URLSessionConfiguration = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30
        return sessionConfig
    }()
    
    private static let sessionManager: SessionManager = {
        let sessionManager = SessionManager(configuration: sessionConfig)
        return sessionManager
    }()
    
    private var request: RequestComposer
    public init(_ request: RequestComposer) {
        self.request = request
    }
    
    private func createURLWithComponents() throws -> URL {
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = request.host
        urlComponent.path = request.path
        urlComponent.queryItems = request.queryItems
        guard let url = urlComponent.url else { throw AFError.parameterEncodingFailed(reason: .missingURL) }
        return url
    }
    
    @discardableResult
    public func fire(onSuccess: ((Results) -> Void)? = nil, onFailure: ((NetworkError) -> Void)? = nil) -> DataRequest {
        
        let requestOpt = NetworkRequest.sessionManager.request(self).validate().responseData { (response) in
            switch response.result {
            case .failure:
                onFailure?(NetworkError.Connection)
            case .success:
                if let data = response.data {
                    NetworkReply.process(data, success: onSuccess, fail: onFailure)
                } else {
                    onFailure?(NetworkError.UnrecognizableResult)
                }
            }
        }
        return requestOpt
    }
}

extension NetworkRequest: URLRequestConvertible {
    
    public func asURLRequest() throws -> URLRequest {
        var urlRequest = try JSONEncoding.default.encode(URLRequest(url: self.createURLWithComponents()), with: request.parameters)
        urlRequest.httpMethod = request.method.rawValue
        return urlRequest
    }
}

public struct NetworkReply {
    
    static func process(_ result: Data, success: ((Results) -> Void)? = nil, fail: ((NetworkError) -> Void)? = nil) {
        do {
            let response = try JSONDecoder().decode(Response.self, from: result)
                success?(response.result)
        } catch {
            fail?(NetworkError.UnrecognizableResult)
        }
    }
}
