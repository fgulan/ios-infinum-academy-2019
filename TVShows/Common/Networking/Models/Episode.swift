//
//  Episode.swift
//  TVShows
//
//  Created by Filip Gulan on 24/07/2018.
//  Copyright © 2018 Filip Gulan. All rights reserved.
//

import Foundation

struct Episode: Codable {
    let showId: String
    let mediaId: String?
    let title: String
    let description: String
    let episodeNumber: String
    let season: String
    let type: String
    let imageUrl: String?
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case showId
        case mediaId
        case title
        case description
        case episodeNumber
        case season
        case type
        case imageUrl
        case id = "_id"
    }
}
