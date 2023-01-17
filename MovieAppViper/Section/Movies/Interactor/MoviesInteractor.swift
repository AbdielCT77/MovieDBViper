//
//  MoviesInteractor.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 17/01/23.
//

import Foundation
import RxSwift

class MoviesInteractor: MoviesPresenterToInteractorProtocol {
    var presenter: MoviesInteractorToPresenterProtocol?
    private let service: NetworkManager
    let bag = DisposeBag()
    
    init(service: NetworkManager = NetworkManager()) {
        self.service = service
    }
    
    func fetchingMovies(homeEnum: HomeEnumSection) {
        presenter?.isLoading(isLoading: true)
        switch homeEnum {
        case .upComingMovie:
            service.fetchUpcomingMovie()
            .observe(on: MainScheduler.instance)
            .subscribe { response in
                self.moviesResponse(response: response)
                self.presenter?.isLoading(isLoading: false)
            } onFailure: { error in
                guard let errorValue = error as? BaseError else { return }
                self.presenter?.fetchFailed(error: errorValue)
            }.disposed(by: bag)
        case .nowPlaying:
            service.fetchPlayingNowMovie()
            .observe(on: MainScheduler.instance)
            .subscribe { response in
                self.moviesResponse(response: response)
                self.presenter?.isLoading(isLoading: false)
            } onFailure: { error in
                guard let errorValue = error as? BaseError else { return }
                self.presenter?.fetchFailed(error: errorValue)
            }.disposed(by: bag)
        case .popularMovie:
            service.fetchPopularMovie()
            .observe(on: MainScheduler.instance)
            .subscribe { response in
                self.moviesResponse(response: response)
                self.presenter?.isLoading(isLoading: false)
            } onFailure: { error in
                guard let errorValue = error as? BaseError else { return }
                self.presenter?.fetchFailed(error: errorValue)
            }.disposed(by: bag)
        }
    }
    
    func fetchingMoviesPaging(homeEnum: HomeEnumSection, page: Int) {
        presenter?.isLoading(isLoading: true)
        switch homeEnum {
        case .upComingMovie:
            service.fetchMoviesUpcomingPaging(page: page)
            .observe(on: MainScheduler.instance)
            .subscribe { response in
                self.moviesPagingResponse(response: response)
                self.presenter?.isLoading(isLoading: false)
            } onFailure: { error in
                self.presenter?.isLoading(isLoading: false)
                guard let errorValue = error as? BaseError else { return }
                self.presenter?.fetchFailed(error: errorValue)
            }.disposed(by: bag)
        case .nowPlaying:
            service.fetchMoviesNowPlayingPaging(page: page)
            .observe(on: MainScheduler.instance)
            .subscribe { response in
                self.moviesPagingResponse(response: response)
                self.presenter?.isLoading(isLoading: false)
            } onFailure: { error in
                self.presenter?.isLoading(isLoading: false)
                guard let errorValue = error as? BaseError else { return }
                self.presenter?.fetchFailed(error: errorValue)
            }.disposed(by: bag)
        case .popularMovie:
            service.fetchMoviesPopularPaging(page: page)
            .observe(on: MainScheduler.instance)
            .subscribe { response in
                self.moviesPagingResponse(response: response)
                self.presenter?.isLoading(isLoading: false)
            } onFailure: { error in
                self.presenter?.isLoading(isLoading: false)
                guard let errorValue = error as? BaseError else { return }
                self.presenter?.fetchFailed(error: errorValue)
            }.disposed(by: bag)
        }

    }
    private func moviesResponse(response: MoviesModelResponse?) {
        self.presenter?.fetchMoviesSuccess(data: response?.results)
    }

    private func moviesPagingResponse(response: MoviesModelResponse?){
        self.presenter?.fetchMoviesPagingSuccess(data: response?.results)
    }

    
    
}
