//
//  DetailMoviePresenter.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 16/01/23.
//

import Foundation
import UIKit

class DetailMoviePresenter: DetailMovieViewToPresenterProtocol {
    var view: DetailMoviePresenterToViewProtocol?
    
    var interactor: DetailMoviePresenterToInteractorProtocol?
    
    var router: DetailMoviePresenterToRouterProtocol?
    
    func fetchMovieDetail(movieId: Int) {
        interactor?.fetchMovieDetail(movieId: movieId)
    }
    
    func showDetailMovieController(
        navigationController: UINavigationController,
        movie: Int
    ) {
        interactor?.fetchMovieDetail(movieId: movie)
    }
    
    func showDetailMovieFromSimilarController(
        navigationController: UINavigationController, movie: Int
    ) {
        router?.showDetailMovieFromSimilarController(
            navigationController: navigationController, movie: movie
        )
    }
    
}

extension DetailMoviePresenter: DetailMovieInteractorToPresenterProtocol {
    func fetchDetailMovieSuccess(data: DetailMovieResponse?) {
        view?.showMovieDetail(data: data)
    }
    
    func fetchFailed(error: BaseError) {
        view?.showError(error: error)
    }
    
    func isLoading(isLoading: Bool) {
        view?.isLoading(isLoading: isLoading)
    }
    
    
}
