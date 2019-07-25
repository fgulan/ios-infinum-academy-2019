//
//  Router.swift
//  TVShows
//
//  Created by Filip Gulan on 29/07/2018.
//  Copyright © 2018 Filip Gulan. All rights reserved.
//

import Foundation
import Alamofire

struct Router: URLRequestConvertible {
    
    private static let base = Constants.URL.baseUrl
    
    private let base: String
    private let path: String
    private let method: HTTPMethod
    private let params: Parameters?
    private let headers: HTTPHeaders?
    private let encoding: ParameterEncoding
    
    private init(base: String, path: String, method: HTTPMethod, params: Parameters?, headers: HTTPHeaders?, encoding: ParameterEncoding) {
        self.base = base
        self.path = path
        self.method = method
        self.params = params
        self.headers = headers
        self.encoding = encoding
    }
    
    init(path: String, method: HTTPMethod = .get, params: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil) {
        self.init(base: Router.base,
                  path: path, method: method,
                  params: params,
                  headers: headers,
                  encoding: encoding)
    }
    
    private func pathURL() throws -> URL {
        if path.starts(with: "http") {
            return try path.asURL()
        }
        return try base.asURL()
            .appendingPathComponent(path)
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try pathURL()
        let originalRequest = try URLRequest(url: url, method: method, headers: headers)
        return try encoding.encode(originalRequest, with: params)
    }
}
