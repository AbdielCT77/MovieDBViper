//
//  MoviesPresenter.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 17/01/23.
//

import Foundation
import UIKit

class MoviesPresenter: MoviesViewToPresenterProtocol {
    var view: MoviesPresenterToViewProtocol?
    var interactor: MoviesPresenterToInteractorProtocol?
    var router: MoviesPresenterToRouterProtocol?
    
    func fetchMovies(homeEnum: HomeEnumSection) {
        interactor?.fetchingMovies(homeEnum: homeEnum)
    }
    
    func fetchMoviesPaging(homeEnum: HomeEnumSection, page: Int) {
        interactor?.fetchingMoviesPaging(homeEnum: homeEnum, page: page)
    }
    
    func showDetailMovieController(
        navigationController: UINavigationController, movie: Int
    ) {
        router?.showDetailMovieController(
            navigationController: navigationController, movie: movie
        )
    }
    
}

extension MoviesPresenter: MoviesInteractorToPresenterProtocol {
    func fetchMoviesPagingSuccess(data: [MoviesModel]?) {
        view?.showMoviesPaging(data: data)
    }
    
    func fetchMoviesSuccess(data: [MoviesModel]?) {
        view?.showMovies(data: data)
    }
    
    func fetchFailed(error: BaseError) {
        view?.showError(error: error)
    }
    
    func isLoading(isLoading: Bool) {
        view?.isLoading(isLoading: isLoading)
    }
    
    
}
