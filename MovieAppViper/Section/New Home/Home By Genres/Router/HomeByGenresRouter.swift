//
//  HomeByGenresRouter.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 15/01/23.
//

import Foundation
import UIKit

class HomeByGenresRouter: HomeByGenresPresenterToRouterProtocol {
    static func createModule() -> HomeByGenresViewController {
        let controller = HomeByGenresViewController()
        let presenter: HomeByGenresViewToPresenterProtocol & HomeByGenresInteractorToPresenterProtocol = HomeByGenresPresenter()
        let interactor: HomeByGenresPresenterToInteractorProtocol = HomeByGenresInteractor()
        let router:HomeByGenresPresenterToRouterProtocol = HomeByGenresRouter()
        
        controller.presenter = presenter
        controller.title = "Movie DB"
        presenter.view = controller
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return controller
    }
    func movePageToMoviesList(
        navigationController: UINavigationController, genre: Genres
    ) {
        let movieModule = MoviesByGenresRouter.createModule()
        movieModule.genre = genre
        navigationController.pushViewController(movieModule, animated: true)
    }
}
