//
//  DetailMovieInteractor.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 16/01/23.
//

import Foundation
import RxSwift

class DetailMovieInteractor: DetailMoviePresenterToInteractorProtocol {
    var presenter: DetailMovieInteractorToPresenterProtocol?
    private let service: NetworkManager
    let bag = DisposeBag()
    
    
    init(service: NetworkManager  = NetworkManager()) {
        self.service = service
    }
    
    func fetchMovieDetail(movieId: Int) {
        presenter?.isLoading(isLoading: true)
        service.fetchMovieDetail(movieId: movieId)
        .observe(on: MainScheduler.instance)
        .subscribe { response in
            self.detailMovieResponse(response: response)
            self.presenter?.isLoading(isLoading: false)
        } onFailure: { error in
            self.presenter?.isLoading(isLoading: false)
            guard let errorValue = error as? BaseError else { return }
            self.presenter?.fetchFailed(error: errorValue)
        }.disposed(by: bag)
    }
    
    private func detailMovieResponse(response: DetailMovieResponse?) {
        self.presenter?.fetchDetailMovieSuccess(data: response)
    }
    
    
}
