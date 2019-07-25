//
//  Show.swift
//  TVShows
//
//  Created by Filip Gulan on 15/07/2018.
//  Copyright © 2018 Filip Gulan. All rights reserved.
//

import Foundation

struct Show: Codable {
    
    let id: String
    let title: String
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case imageUrl
        case id = "_id"
    }
}
