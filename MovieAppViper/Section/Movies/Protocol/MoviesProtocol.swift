//
//  MoviesProtocol.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 17/01/23.
//

import Foundation
import UIKit

protocol MoviesViewToPresenterProtocol: AnyObject {
    var view: MoviesPresenterToViewProtocol? {get set}
    var interactor: MoviesPresenterToInteractorProtocol? {get set}
    var router: MoviesPresenterToRouterProtocol? {get set}
    func fetchMovies(homeEnum: HomeEnumSection)
    func fetchMoviesPaging(homeEnum: HomeEnumSection, page: Int)
    func showDetailMovieController(
        navigationController: UINavigationController, movie: Int
    )
}

protocol MoviesPresenterToViewProtocol: AnyObject {
    func showMovies(data: [MoviesModel]?)
    func showMoviesPaging(data: [MoviesModel]?)
    func showError(error: BaseError)
    func isLoading(isLoading: Bool)
}

protocol MoviesPresenterToRouterProtocol: AnyObject {
    static func createModule(homeEnum: HomeEnumSection)-> MoviesViewController
    func showDetailMovieController(
        navigationController: UINavigationController, movie: Int
    )
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
