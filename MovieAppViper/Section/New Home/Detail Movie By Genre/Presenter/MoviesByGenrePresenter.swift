//
//  MoviesByGenrePresenter.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 15/01/23.
//

import Foundation

class MoviesByGenresPresenter: MoviesByGenresViewToPresenterProtocol {
    var view: MoviesByGenresPresenterToViewProtocol?
    var interactor: MoviesByGenresPresenterToInteractorProtocol?
    var router: MoviesByGenresPresenterToRouterProtocol?
    
    func fetchMovies(genre: Genres) {
        interactor?.fetchingMovies(genre: genre)
    }
    
    func fetchMoviesPaging(genre: Genres, page: Int) {
        interactor?.fetchingMoviesPaging(genre: genre, page: page)
    }
}

extension MoviesByGenresPresenter: MoviesByGenresInteractorToPresenterProtocol {
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
