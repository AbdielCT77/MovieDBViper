//
//  HomePresenter.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 13/01/23.
//

import Foundation
import UIKit

class HomePresenter: ViewToPresenterProtocol {
    var view: PresenterToViewProtocol?
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    
    func fetchItemHome() {
        interactor?.fetchingHome()
    }
    
    func showDetailMovieController(
        navigationController: UINavigationController, movie: Int
    ) {
        router?.showDetailMovieController(
            navigationController: navigationController, movie: movie
        )
    }
    
    func showMovieController(
        navigationController: UINavigationController, enumHome: HomeEnumSection
    ) {
        router?.showMovieController(
            navigationController: navigationController, enumHome: enumHome
        )
    }
    
}

extension HomePresenter: InteractorToPresenterProtocol {
    func fetchedUpcomingMoviesSuccess(data: [MoviesModel]?) {
        view?.showUpcomingMovies(data: data)
    }
    
    func showNowPlayingMovie(data: [MoviesModel]?) {
        view?.showNowPlayingMovie(data: data)
    }
    
    func showPopularMoviesData(data: [MoviesModel]?) {
        view?.showPopularMoviesData(data: data)
    }
    
    func fetchFailed(error: BaseError) {
        view?.showError(error: error)
    }
    
    func isLoading(isLoading: Bool) {
        view?.isLoading(isLoading: isLoading)
    }
    
    
}
