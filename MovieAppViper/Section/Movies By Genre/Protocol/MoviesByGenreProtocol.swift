//
//  MoviesByGenreProtocol.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 15/01/23.
//

import Foundation
import UIKit

protocol MoviesByGenresViewToPresenterProtocol: AnyObject {
    var view: MoviesByGenresPresenterToViewProtocol? {get set}
    var interactor: MoviesByGenresPresenterToInteractorProtocol? {get set}
    var router: MoviesByGenresPresenterToRouterProtocol? {get set}
    func fetchMovies(genre: Genres)
    func fetchMoviesPaging(genre: Genres,page: Int)
    
}

protocol MoviesByGenresPresenterToViewProtocol: AnyObject {
    func showMovies(data: [MoviesModel]?)
    func showMoviesPaging(data: [MoviesModel]?)
    func showError(error: BaseError)
    func isLoading(isLoading: Bool)
}

protocol MoviesByGenresPresenterToRouterProtocol: AnyObject {
    static func createModule(genre: Genres)-> MoviesByGenreViewController
}

protocol MoviesByGenresPresenterToInteractorProtocol: AnyObject {
    var presenter:MoviesByGenresInteractorToPresenterProtocol? {get set}
    func fetchingMovies(genre: Genres)
    func fetchingMoviesPaging(genre: Genres,page: Int)
}

protocol MoviesByGenresInteractorToPresenterProtocol: AnyObject {
    func fetchMoviesSuccess(data: [MoviesModel]?)
    func fetchMoviesPagingSuccess(data: [MoviesModel]?)
    func fetchFailed(error: BaseError)
    func isLoading(isLoading: Bool)
}
