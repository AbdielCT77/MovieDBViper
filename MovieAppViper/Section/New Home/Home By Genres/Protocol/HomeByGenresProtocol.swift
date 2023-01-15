//
//  HomeByGenresProtocol.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 15/01/23.
//

import Foundation
import UIKit

protocol HomeByGenresViewToPresenterProtocol: AnyObject {
    var view: HomeByGenresPresenterToViewProtocol? {get set}
    var interactor: HomeByGenresPresenterToInteractorProtocol? {get set}
    var router: HomeByGenresPresenterToRouterProtocol? {get set}
    func fetchGenres()
    func movePageToMoviesList(
        navigationController: UINavigationController, genre: Genres
    )
    
}

protocol HomeByGenresPresenterToViewProtocol: AnyObject {
    func showGenres(data: [Genres]?)
    func showError(error: BaseError)
    func isLoading(isLoading: Bool)
}

protocol HomeByGenresPresenterToRouterProtocol: AnyObject {
    static func createModule()-> HomeByGenresViewController
    func movePageToMoviesList(
        navigationController: UINavigationController, genre: Genres
    )
}

protocol HomeByGenresPresenterToInteractorProtocol: AnyObject {
    var presenter:HomeByGenresInteractorToPresenterProtocol? {get set}
    func fetchingGenres()
}

protocol HomeByGenresInteractorToPresenterProtocol: AnyObject {
    func fetchGenresSuccess(data: [Genres]?)
    func fetchFailed(error: BaseError)
    func isLoading(isLoading: Bool)
}
