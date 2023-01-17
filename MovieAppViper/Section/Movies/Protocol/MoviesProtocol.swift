//
//  MoviesProtocol.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 17/01/23.
//

import Foundation

protocol MoviesViewToPresenterProtocol: AnyObject {
    var view: MoviesPresenterToViewProtocol? {get set}
    var interactor: MoviesPresenterToInteractorProtocol? {get set}
    var router: MoviesPresenterToRouterProtocol? {get set}
    func fetchMovies(homeEnum: HomeEnumSection)
    func fetchMoviesPaging(homeEnum: HomeEnumSection, page: Int)
    
}

protocol MoviesPresenterToViewProtocol: AnyObject {
    func showMovies(data: [MoviesModel]?)
    func showMoviesPaging(data: [MoviesModel]?)
    func showError(error: BaseError)
    func isLoading(isLoading: Bool)
}

protocol MoviesPresenterToRouterProtocol: AnyObject {
    static func createModule(homeEnum: HomeEnumSection)-> MoviesViewController
}

protocol MoviesPresenterToInteractorProtocol: AnyObject {
    var presenter:MoviesInteractorToPresenterProtocol? {get set}
    func fetchingMovies(homeEnum: HomeEnumSection)
    func fetchingMoviesPaging(homeEnum: HomeEnumSection, page: Int)
}

protocol MoviesInteractorToPresenterProtocol: AnyObject {
    func fetchMoviesSuccess(data: [MoviesModel]?)
    func fetchMoviesPagingSuccess(data: [MoviesModel]?)
    func fetchFailed(error: BaseError)
    func isLoading(isLoading: Bool)
}
