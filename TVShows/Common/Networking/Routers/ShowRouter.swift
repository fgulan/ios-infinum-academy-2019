//
//  HomeRouter.swift
//  TVShows
//
//  Created by Filip Gulan on 29/07/2018.
//  Copyright © 2018 Filip Gulan. All rights reserved.
//

import Foundation
import Alamofire

extension Router {
    
    enum Show {
        
        static func getShows() -> Router {
            return Router(
                path: "/shows",
                method: .get,
                encoding: JSONEncoding.default
            )
        }
    }
}
