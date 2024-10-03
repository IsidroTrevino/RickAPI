//
//  Episode.swift
//  RickAPI
//
//  Created by Isidro Treviño on 01/10/24.
//

import Foundation

struct ResponseEpisode: Codable {
    let results: [Episode]
}

struct Episode: Codable {
    var id : Int
    var name: String
    var airDate: String
    var episodeCode: String
    var characters: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episodeCode = "episode"
        case characters
    }
}
