//
//  MoviesByGenreInteractor.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 15/01/23.
//

import Foundation
import RxSwift

class MoviesByGenresInteractor: MoviesByGenresPresenterToInteractorProtocol {
    var presenter: MoviesByGenresInteractorToPresenterProtocol?
    private let service: NetworkManager
    let bag = DisposeBag()
    
    init(service: NetworkManager = NetworkManager()) {
        self.service = service
    }
    
    func fetchingMovies(genre: Genres) {
        presenter?.isLoading(isLoading: true)
        service.fetchMoviesByGenre(genre: String(genre.id ?? 0))
        .observe(on: MainScheduler.instance)
        .subscribe { response in
            self.moviesByGenreResponse(response: response)
            self.presenter?.isLoading(isLoading: false)
        } onFailure: { error in
            guard let errorValue = error as? BaseError else { return }
            self.presenter?.fetchFailed(error: errorValue)
        }.disposed(by: bag)
    }
    
    func fetchingMoviesPaging(genre: Genres, page: Int) {
        presenter?.isLoading(isLoading: true)
        service.fetchMoviesByGenrePaging(page: page, genre: String(genre.id ?? 0))
        .observe(on: MainScheduler.instance)
        .subscribe { response in
            self.moviesByGenrePagingResponse(response: response)
            self.presenter?.isLoading(isLoading: false)
        } onFailure: { error in
            self.presenter?.isLoading(isLoading: false)
            guard let errorValue = error as? BaseError else { return }
            self.presenter?.fetchFailed(error: errorValue)
        }.disposed(by: bag)
    }
    
    private func moviesByGenreResponse(response: MoviesModelResponse?) {
        self.presenter?.fetchMoviesSuccess(data: response?.results)
    }
    
    private func moviesByGenrePagingResponse(response: MoviesModelResponse?){
        self.presenter?.fetchMoviesPagingSuccess(data: response?.results)
    }
    
    
    
}


