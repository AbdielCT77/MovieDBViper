//
//  DetailMovieRouter.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 16/01/23.
//

import Foundation
import UIKit

class DetailMovieRouter: DetailMoviePresenterToRouterProtocol {
    
    static func createModule(movieId: Int) -> DetailMovieViewController {
        let controller = DetailMovieViewController()
        let presenter: DetailMovieViewToPresenterProtocol & DetailMovieInteractorToPresenterProtocol = DetailMoviePresenter()
        let interactor: DetailMoviePresenterToInteractorProtocol = DetailMovieInteractor()
        let router:DetailMoviePresenterToRouterProtocol = DetailMovieRouter()
        
        controller.presenter = presenter
        controller.title = "Movie DB"
        controller.movieId = movieId
        presenter.view = controller
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return controller
    }
    
    func showDetailMovieFromSimilarController(
        navigationController: UINavigationController, movie: Int
    ) {
        let movieModule = DetailMovieRouter.createModule(movieId: movie)
        navigationController.pushViewController(movieModule, animated: true)
    }
}
