//
//  AnimeResponse.swift
//  jikanmoe
//
//  Created by Satoru Ishii on 5/6/21.
//

import Foundation

///
/// Anime Search Result Codable Data Model
///
struct AnimeSearchResponse : Codable {
    
    let results : [Anime]?
    
    enum CodingKeys : String, CodingKey {
        case results
    }
    
}
///
/// Anime Data Model
///
struct Anime : Codable {

    let mal_id : Int
    let title : String
    let url : String
    let image_url : String
    let type : String
    let score : Double
    let members : Int
    
    enum CodingKeys : String, CodingKey {
        case mal_id
        case title
        case url
        case image_url
        case type
        case score
        case members
    }
}
