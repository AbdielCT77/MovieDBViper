//
//  HomeByGenresInteractor.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 15/01/23.
//

import Foundation
import RxSwift

class HomeByGenresInteractor: HomeByGenresPresenterToInteractorProtocol {
    var presenter: HomeByGenresInteractorToPresenterProtocol?
    private let service: NetworkManager
    let bag = DisposeBag()
    
    init(service: NetworkManager = NetworkManager()) {
        self.service = service
    }
    
    func fetchingGenres() {
        presenter?.isLoading(isLoading: true)
        service.fetchGenres()
        .observe(on: MainScheduler.instance)
        .subscribe { response in
            self.genreMovieResponse(response: response)
            self.presenter?.isLoading(isLoading: false)
        } onFailure: { error in
            guard let errorValue = error as? BaseError else { return }
            self.presenter?.fetchFailed(error: errorValue)
        }.disposed(by: bag)

    }
    
    private func genreMovieResponse(response: GenresModelResponse?) {
        self.presenter?.fetchGenresSuccess(data: response?.genres)
    }
    
    
}
