//
//  DetailMovieProtocol.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 16/01/23.
//

import Foundation

protocol DetailMovieViewToPresenterProtocol: AnyObject {
    var view: DetailMoviePresenterToViewProtocol? {get set}
    var interactor: DetailMoviePresenterToInteractorProtocol? {get set}
    var router: DetailMoviePresenterToRouterProtocol? {get set}
    func fetchMovieDetail(movieId: Int)
    
}

protocol DetailMoviePresenterToViewProtocol: AnyObject {
    func showMovieDetail(data: DetailMovieResponse?)
    func showError(error: BaseError)
    func isLoading(isLoading: Bool)
}

protocol DetailMoviePresenterToRouterProtocol: AnyObject {
    static func createModule(movieId: Int)-> DetailMovieViewController
}

protocol DetailMoviePresenterToInteractorProtocol: AnyObject {
    var presenter:DetailMovieInteractorToPresenterProtocol? {get set}
    func fetchMovieDetail(movieId: Int)
}

protocol DetailMovieInteractorToPresenterProtocol: AnyObject {
    func fetchDetailMovieSuccess(data: DetailMovieResponse?)
    func fetchFailed(error: BaseError)
    func isLoading(isLoading: Bool)
}
