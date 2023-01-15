//
//  HomeByGenresPresenter.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 15/01/23.
//

import Foundation
import UIKit

class HomeByGenresPresenter: HomeByGenresViewToPresenterProtocol {
    
    var view: HomeByGenresPresenterToViewProtocol?
    var interactor: HomeByGenresPresenterToInteractorProtocol?
    var router: HomeByGenresPresenterToRouterProtocol?
    
    func fetchGenres() {
        interactor?.fetchingGenres()
    }
    
    func movePageToMoviesList(navigationController: UINavigationController, genre: Genres) {
        router?.movePageToMoviesList(
            navigationController: navigationController, genre: genre
        )
    }
}

extension HomeByGenresPresenter: HomeByGenresInteractorToPresenterProtocol {
    func fetchGenresSuccess(data: [Genres]?) {
        view?.showGenres(data: data)
    }
    
    func fetchFailed(error: BaseError) {
        view?.showError(error: error)
    }
    
    func isLoading(isLoading: Bool) {
        view?.isLoading(isLoading: isLoading)
    }
    
    
}
