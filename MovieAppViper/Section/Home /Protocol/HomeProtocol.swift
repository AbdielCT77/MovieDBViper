//
//  HomeProtocol.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 13/01/23.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol: AnyObject {
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func fetchItemHome()
    func showDetailMovieController(
        navigationController: UINavigationController, movie: Int
    )
    func showMovieController(
        navigationController: UINavigationController, enumHome: HomeEnumSection
    )
}

protocol PresenterToViewProtocol: AnyObject {
    func showUpcomingMovies(data: [MoviesModel]?)
    func showNowPlayingMovie(data: [MoviesModel]?)
    func showPopularMoviesData(data: [MoviesModel]?)
    func showError(error: BaseError)
    func isLoading(isLoading: Bool)
}

protocol PresenterToRouterProtocol: AnyObject {
    static func createModule()-> HomeViewController
    func showDetailMovieController(
        navigationController: UINavigationController, movie: Int
    )
    func showMovieController(
        navigationController: UINavigationController, enumHome: HomeEnumSection
    )
}

protocol PresenterToInteractorProtocol: AnyObject {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchingHome()
}

protocol InteractorToPresenterProtocol: AnyObject {
    func fetchedUpcomingMoviesSuccess(data: [MoviesModel]?)
    func showNowPlayingMovie(data: [MoviesModel]?)
    func showPopularMoviesData(data: [MoviesModel]?)
    func fetchFailed(error: BaseError)
    func isLoading(isLoading: Bool)
}

