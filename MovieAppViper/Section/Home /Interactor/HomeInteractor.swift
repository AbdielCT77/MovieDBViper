//
//  HomeInteractor.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 13/01/23.
//

import Foundation
import RxSwift

class HomeInteractor: PresenterToInteractorProtocol {
    var presenter: InteractorToPresenterProtocol?
    private let service: NetworkManager
    let bag = DisposeBag()
    
    init(service: NetworkManager = NetworkManager()) {
        self.service = service
    }
    
    func fetchingHome() {
        presenter?.isLoading(isLoading: true)
        Observable.zip(
            service.fetchPlayingNowMovie().asObservable(),
            service.fetchPopularMovie().asObservable().asObservable(),
            service.fetchUpcomingMovie().asObservable()
        )
        .observe(on: MainScheduler.instance)
        .subscribe { (nowPlayingResponse, popularResponse, upcomingResponse) in
            self.playingNowResponse(response: nowPlayingResponse)
            self.popularMovieResponse(response: popularResponse)
            self.upcomingMovieResponse(response: upcomingResponse)
            self.presenter?.isLoading(isLoading: false)
        } onError: { error in
            self.presenter?.isLoading(isLoading: false)
            guard let errorValue = error as? BaseError else { return }
            self.presenter?.fetchFailed(error: errorValue)
        }.disposed(by: bag)

    }
    
    private func upcomingMovieResponse(response: MoviesModelResponse?) {
        self.presenter?.fetchedUpcomingMoviesSuccess(data: response?.results)
    }
    
    private func playingNowResponse(response: MoviesModelResponse?) {
        self.presenter?.showNowPlayingMovie(data: response?.results)
    }
    
    private func popularMovieResponse(response: MoviesModelResponse?) {
        self.presenter?.showPopularMoviesData(data: response?.results)
    }
    
    
}
