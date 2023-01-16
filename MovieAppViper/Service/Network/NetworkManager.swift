//
//  NetworkManager.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 13/01/23.
//

import RxSwift
import RxCocoa
import Moya

class NetworkManager: NetworkManagerProtocol {
    private let provider = MoyaProvider<NetworkService>(plugins: [NetworkLoggerPlugin.verbose])
    
    func request<T: Codable>(networkService: NetworkService) -> Single<T?> {
//        if !Reachability.isConnectedToNetwork() {
//            return Single.error(APIError(with: .internetConnection, message: "No Internet Connection"))
//        }
        
        return provider
            .rx.request(networkService)
            .observe(on: ConcurrentDispatchQueueScheduler(
                qos: DispatchQoS(
                    qosClass: DispatchQoS.QoSClass.background,
                    relativePriority: 1))
            )
            .catch { error -> PrimitiveSequence<SingleTrait, Response> in
                return Single.error(
                    BaseError.custom(
                        code: "0",
                        title: "API FAILURE",
                        desc: error.localizedDescription)
                )
            }.flatMap {json -> Single<T?> in
                if json.statusCode >= 200 && json.statusCode <= 300 {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    if let response = try? decoder.decode(T.self, from: json.data) {
                        return Single.just(response)
                    }
                } else {
                    let error = BaseError.custom(
                        code: "0",
                        title: "Failed",
                        desc: "Internal Server Error"
                    )
                    return Single.error(error)
                }
                let error = BaseError.custom(
                    code: "0",
                    title: "Failed",
                    desc: "Failed to parse response"
                )
                return Single.error(error)
            }
    }
    
    func fetchUpcomingMovie() -> RxSwift.Single<MoviesModelResponse?> {
        return request(networkService: .upComingMovie)
    }
    
    func fetchPlayingNowMovie() -> RxSwift.Single<MoviesModelResponse?> {
        return request(networkService: .nowPlaying)
    }
    
    func fetchPopularMovie() -> RxSwift.Single<MoviesModelResponse?> {
        return request(networkService: .popularMovie)
    }
    
    func fetchGenres() -> Single<GenresModelResponse?> {
        return request(networkService: .genreMovie)
    }
    
    func fetchMoviesByGenre(genre: String) -> Single<MoviesModelResponse?> {
        return request(networkService: .movieByGenres(genre: genre))
    }
    
    func fetchMoviesByGenrePaging(page: Int, genre: String) -> Single<MoviesModelResponse?> {
        return request(networkService: .movieByGenresPaging(genre: genre, page: page))
    }
    
    func fetchMovieDetail(movieId: Int) -> Single<DetailMovieResponse?> {
        return request(networkService: .detailMovie(id: movieId))
    }
}
