//
//  DetailMoviePresenter.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 16/01/23.
//

import Foundation

class DetailMoviePresenter: DetailMovieViewToPresenterProtocol {
    var view: DetailMoviePresenterToViewProtocol?
    
    var interactor: DetailMoviePresenterToInteractorProtocol?
    
    var router: DetailMoviePresenterToRouterProtocol?
    
    func fetchMovieDetail(movieId: Int) {
        interactor?.fetchMovieDetail(movieId: movieId)
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
