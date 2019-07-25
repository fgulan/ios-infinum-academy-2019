//
//  ShowsSessionManager.swift
//  TVShows
//
//  Created by Filip Gulan on 29/07/2018.
//  Copyright © 2018 Filip Gulan. All rights reserved.
//

import Foundation
import Alamofire
import RxCocoa
import RxSwift
#if DEV
import Loggie
#endif

class ShowsSessionManager {
    
    static var session: SessionManager = {
        #if DEV
            let configuration = URLSessionConfiguration.loggie
            configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
            return SessionManager(configuration: configuration)
        #else
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
            return SessionManager(configuration: configuration)
        #endif
    }()
    
    private init() {}
}

class TokenAdapter: RequestAdapter {
    
    private let _token: String
    
    init(token: String) {
        _token = token
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue(_token, forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}
