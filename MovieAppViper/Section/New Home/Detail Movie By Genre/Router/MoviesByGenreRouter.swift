//
//  MoviesByGenreRouter.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 15/01/23.
//

import Foundation
import UIKit

class MoviesByGenresRouter: MoviesByGenresPresenterToRouterProtocol {
    
    static func createModule() -> MoviesByGenreViewController {
        let controller = MoviesByGenreViewController()
        let presenter: MoviesByGenresViewToPresenterProtocol & MoviesByGenresInteractorToPresenterProtocol = MoviesByGenresPresenter()
        let interactor: MoviesByGenresPresenterToInteractorProtocol = MoviesByGenresInteractor()
        let router:MoviesByGenresPresenterToRouterProtocol = MoviesByGenresRouter()
        
        controller.presenter = presenter
        controller.title = "Movie DB"
        presenter.view = controller
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return controller
    }
    
}

