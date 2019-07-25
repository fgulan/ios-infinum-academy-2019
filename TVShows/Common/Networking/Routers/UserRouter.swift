//
//  UserRouter.swift
//  TVShows
//
//  Created by Filip Gulan on 29/07/2018.
//  Copyright © 2018 Filip Gulan. All rights reserved.
//

import Foundation
import Alamofire

extension Router {
    
    enum User {
        
        static func loginWith(email: String, password: String) -> Router {
            let params = [
                "email": email,
                "password": password
            ]
            
            return Router(
                path: "/users/sessions",
                method: .post,
                params: params,
                encoding: JSONEncoding.default
            )
        }

        static func registerWith(email: String, password: String) -> Router {
            let params = [
                "email": email,
                "password": password
            ]

            return Router(
                path: "/users",
                method: .post,
                params: params,
                encoding: JSONEncoding.default
            )
        }
    }
}
