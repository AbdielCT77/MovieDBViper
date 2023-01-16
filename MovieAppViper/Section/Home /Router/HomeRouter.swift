//
//  HomeRouter.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 13/01/23.
//

import Foundation
import UIKit

class HomeRouter: PresenterToRouterProtocol{
    static func createModule() -> HomeViewController {
        let controller = HomeViewController()
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = HomePresenter()
        let interactor: PresenterToInteractorProtocol = HomeInteractor()
        let router:PresenterToRouterProtocol = HomeRouter()
        
        controller.presenter = presenter
        controller.title = "Movie DB"
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
