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
    
    internal let menuSection: [HomeEnumSection] = [
        .nowPlaying, .popularMovie, .upComingMovie
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
        tableView.register(
            HomePopularTableViewCell.nib(),
            forCellReuseIdentifier: HomePopularTableViewCell.identifier
        )
        tableView.register(
            HomeUpcomingTableViewCell.nib(),
            forCellReuseIdentifier: HomeUpcomingTableViewCell.identifier
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
        dataMovieUpcoming = data ?? []
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuSection.count
    }
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        switch menuSection[section] {
        case .upComingMovie:
            return 1
        case .nowPlaying:
            return 1
        case .popularMovie:
            return dataMoviePopular.count < 6 ? dataMoviePopular.count : 5
        }
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch menuSection[indexPath.section] {
        case .upComingMovie:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomeUpcomingTableViewCell.identifier,
                for: indexPath
            ) as! HomeUpcomingTableViewCell
            cell.presenter = presenter
            cell.navigationController = self.navigationController
            cell.configureData(model: dataMovieUpcoming)
            return cell
        case .nowPlaying:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomeNowPlayingTableViewCell.identifier,
                for: indexPath
            ) as! HomeNowPlayingTableViewCell
            cell.presenter = presenter
            cell.navigationController = self.navigationController
            cell.configureData(model: dataMoviePlayingNow)
            return cell
        case .popularMovie:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomePopularTableViewCell.identifier,
                for: indexPath
            ) as! HomePopularTableViewCell
            if dataMoviePopular.count > 0 {
                cell.configureCell(model: dataMoviePopular[indexPath.row])
                cell.navigationController = self.navigationController
            }
            return cell
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        switch menuSection[section] {
        case .upComingMovie:
            return menuSection[section].title
        case .nowPlaying:
            return menuSection[section].title
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
            return 200
        case .nowPlaying:
            return 300
        case .popularMovie:
            return 200
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        presenter?.showDetailMovieController(
            navigationController: self.navigationController ?? UINavigationController(),
            movie: dataMoviePopular[indexPath.row].id ?? 0
        )
    }
}
