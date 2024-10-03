//
//  Character.swift
//  RickAPI
//
//  Created by Isidro Treviño on 01/10/24.
//

import Foundation

struct ResponseCharacter: Codable {
    let results: [Character]
}

struct Character: Codable, Identifiable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: Origin
    var location: Location
    var image: String
    var episode: [String]
}

struct Origin : Codable {
    var name : String
    var url : String
}

struct Location : Codable {
    var name : String
    var url : String
}
