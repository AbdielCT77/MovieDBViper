//
//  HomeViewController.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 14/01/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - UI Variable -
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Variable -
    var presenter: ViewToPresenterProtocol?
    var dataMoviePlayingNow: [MoviesModel] = []
    var dataMovieUpcoming: [MoviesModel] = []
    var dataMoviePopular: [MoviesModel] = []
    var dataMovieTrending: [MoviesModel] = []
    
    internal let menuSection: [HomeEnumSection] = [
        .nowPlaying, .popularMovie, .upComingMovie, .trendingMovie
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        fetchPresenter()
    }
    
    private func setUI(){
        tableView.register(
            HomeNowPlayingTableViewCell.nib(),
            forCellReuseIdentifier: HomeNowPlayingTableViewCell.identifier
        )
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    private func fetchPresenter(){
        presenter?.fetchItemHome()
    }

}

extension HomeViewController: PresenterToViewProtocol {
    func showUpcomingMovies(data: [MoviesModel]?) {
        dataMoviePopular = data ?? []
        tableView.reloadData()
    }
    
    func showNowPlayingMovie(data: [MoviesModel]?) {
        dataMoviePlayingNow = data ?? []
        tableView.reloadData()
    }
    
    func showPopularMoviesData(data: [MoviesModel]?) {
        dataMoviePopular = data ?? []
        tableView.reloadData()
    }
    
    func showError(error: BaseError) {
        print("ini error, ", error.getError.getDesc())
    }
    
    func isLoading(isLoading: Bool) {
        print("ini loading, ", isLoading)
    }
    
    
}



extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        switch menuSection[section] {
        case .upComingMovie:
            return 1
        case .trendingMovie:
            return 1
        case .nowPlaying:
            return 1
        case .popularMovie:
            return 1
        }
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch menuSection[indexPath.section] {
        case .upComingMovie:
            print("ini upcoming bor")
            return UITableViewCell()
        case .trendingMovie:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomeTrendingMovieTableViewCell.identifier,
                for: indexPath
            ) as! HomeTrendingMovieTableViewCell
            cell.presenter = presenter
            cell.configureData(model: dataMoviePlayingNow)
            return cell
        case .nowPlaying:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomeNowPlayingTableViewCell.identifier,
                for: indexPath
            ) as! HomeNowPlayingTableViewCell
            cell.presenter = presenter
            cell.configureData(model: dataMoviePlayingNow)
            return cell
        case .popularMovie:
            print("ini popular bor")
            return UITableViewCell()
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        switch menuSection[section] {
        case .upComingMovie:
            return menuSection[section].title
        case .trendingMovie:
            return menuSection[section].title
        case .nowPlaying:
            return ""
        case .popularMovie:
            return menuSection[section].title
        }
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        switch menuSection[indexPath.section] {
        case .upComingMovie:
            return 0
        case .trendingMovie:
            return 0
        case .nowPlaying:
            return 300
        case .popularMovie:
            return 0
        }
    }
}
