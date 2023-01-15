//
//  MoviesModelResponse.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 13/01/23.
//

import Foundation

struct MoviesModelResponse : Codable{
    var results: [MoviesModel]?
    var pages: Int?
    var totalResults: Int?
    var totalPages: Int?
}

struct MoviesModel : Codable{
    var voteCount: Int?
    var id: Int?
    var video: Bool?
    var voteAverage: Float?
    var title: String?
    var popularity: Double?
    var posterPath: String?
    var originalLanguage: String?
    var originalTitle: String?
    var genreIds: [Int]?
    var backdropPath: String?
    var adule: Bool?
    var overview: String?
    var releaseDate: String?
}
