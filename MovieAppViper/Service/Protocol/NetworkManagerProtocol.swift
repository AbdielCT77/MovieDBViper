//
//  NetworkManagerProtocol.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 13/01/23.
//

import RxSwift

protocol NetworkManagerProtocol {
    func fetchUpcomingMovie() -> Single<MoviesModelResponse?>
    func fetchPlayingNowMovie() -> Single<MoviesModelResponse?>
    func fetchPopularMovie() -> Single<MoviesModelResponse?>
    func fetchGenres() -> Single<GenresModelResponse?>
}
