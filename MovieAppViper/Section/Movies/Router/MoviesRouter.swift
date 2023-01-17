//
//  MoviesRouter.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 17/01/23.
//

import Foundation
import UIKit

class MoviesRouter: MoviesPresenterToRouterProtocol {
    
    static func createModule(homeEnum: HomeEnumSection) -> MoviesViewController {
        let controller = MoviesViewController()
        let presenter: MoviesViewToPresenterProtocol & MoviesInteractorToPresenterProtocol = MoviesPresenter()
        let interactor: MoviesPresenterToInteractorProtocol = MoviesInteractor()
        let router:MoviesPresenterToRouterProtocol = MoviesRouter()
        
        controller.presenter = presenter
        controller.title = homeEnum.title
        controller.enumHome = homeEnum
        presenter.view = controller
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return controller
    }
    
    func showDetailMovieController(
        navigationController: UINavigationController, movie: Int
    ) {
        let movieModule = DetailMovieRouter.createModule(movieId: movie)
        navigationController.pushViewController(movieModule, animated: true)
    }
}

