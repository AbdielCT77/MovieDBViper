//
//  GenresModelResponse.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 15/01/23.
//

import Foundation

struct GenresModelResponse : Codable{
    var genres: [Genres]?
}

struct Genres : Codable{
    var id: Int?
    var name: String?
}
