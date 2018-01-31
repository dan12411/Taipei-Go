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
        sessionConfig.timeoutIntervalForRequest = 20
        return sessionConfig
    }()
    
    private static let sessionManager: SessionManager = {
        let sessionManager = SessionManager(configuration: sessionConfig)
//        sessionManager.retrier = Retrier.shared
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
    public func fire<T>(onSuccess: ((T) -> Void)? = nil, onFailure: ((NetworkError) -> Void)? = nil) -> DataRequest where T : Codable {
        
        let requestOpt = NetworkRequest.sessionManager.request(self).validate().responseData { (response) in
            switch response.result {
            case .failure:
                onFailure?(NetworkError.Connection)
            case .success:
                if let data = response.data {
//                    Reply.process(data, success: onSuccess, fail: onFailure)
                    print("get data!")
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
