//
//  DetailMovieResponseModel.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 16/01/23.
//

import Foundation

// MARK: - DetailMovieResponse
struct DetailMovieResponse: Codable {
    let adult: Bool?
    let backdropPath: String?
    let belongsToCollection: BelongsToCollection?
    let budget: Int?
    let genres: [Genres]?
    let homepage: String?
    let id: Int?
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: [SpokenLanguage]
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let credits: Credits?
    let externalIds: ExternalIDS?
    let videos: Videos?
    let similar: MoviesModelResponse?

}

// MARK: - Credits
struct Credits: Codable {
    let cast, crew: [Cast]?
}

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool
    let gender, id: Int?
    let knownForDepartment: String?
    let name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String?
    let order: Int?
    let department: String?
    let job: String?

}


// MARK: - BelongsToCollection
struct BelongsToCollection: Codable {
    let id: Int
    let name: String
    let posterPath, backdropPath: String?
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int?
    let logoPath: String?
    let name, originCountry: String?
    

}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String?
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String?
    
}

// MARK: - ExternalIDS
struct ExternalIDS: Codable {
    let imdbId, facebookId, instagramId, twitterId: String?
}

// MARK: - Videos
struct Videos: Codable {
    let results: [ResultVideos]?
}

// MARK: - Result
struct ResultVideos : Codable {
    let iso639_1: String?
    let iso3166_1: String?
    let name, key: String?
    let site: String?
    let size: Int?
    let type: String?
    let official: Bool?
    let publishedAt, id: String?

}
