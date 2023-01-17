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
    var dataGenres: [Genres] = []
    
    internal let menuSection: [HomeEnumSection] = [
        .nowPlaying, .popularMovie, .upComingMovie, .genre
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
        tableView.register(
            HomeGenreTableViewCell.nib(),
            forCellReuseIdentifier: HomeGenreTableViewCell.identifier
        )
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
//        tableView.estimatedRowHeight = view.frame.height
//        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func fetchPresenter(){
        presenter?.fetchItemHome()
    }

}

extension HomeViewController: PresenterToViewProtocol {
    func showGenres(data: [Genres]?) {
        dataGenres = data ?? []
        tableView.reloadData()
    }
    
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
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(
            x: 0, y: 0,
            width: tableView.frame.width, height: 50)
        )
        
        let label = UILabel()
        label.frame = CGRect.init(
            x: 10, y: 5,
            width: headerView.frame.width/2, height: headerView.frame.height/2
        )
        label.text = menuSection[section].title
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        
        let seeAll = UILabel()
        seeAll.frame = CGRect.init(
            x: headerView.frame.width - 80, y: 5,
            width: headerView.frame.width/2, height: headerView.frame.height/2
        )
        seeAll.text = "See All"
        seeAll.font = .systemFont(ofSize: 14)
        seeAll.textColor = .lightGray
        seeAll.isUserInteractionEnabled = true
        seeAll.tag = section
        
        headerView.backgroundColor = .white
        
        headerView.addSubview(label)
        if !(menuSection[section] == .genre) {
            headerView.addSubview(seeAll)
            onClickSeeAll(view: seeAll)
        }
        
        return headerView
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
        case .genre:
            return 1
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
        case .genre:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomeGenreTableViewCell.identifier,
                for: indexPath
            ) as! HomeGenreTableViewCell
            cell.configureData(genre: dataGenres)
            cell.presenter = presenter
            cell.navigationController = self.navigationController
            return cell
        }
    }

    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        return 50
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
        case .genre:
            return 700
        }
    }
    
//    func tableView(
//        _ tableView: UITableView,
//        heightForRowAt indexPath: IndexPath
//    ) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        presenter?.showDetailMovieController(
            navigationController: self.navigationController ?? UINavigationController(),
            movie: dataMoviePopular[indexPath.row].id ?? 0
        )
    }
    
    private func onClickSeeAll(view: UIView) {
        let tap = UITapGestureRecognizer(
            target: self, action: #selector(seeAlltapped)
        )
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func seeAlltapped(sender: UITapGestureRecognizer) {
        let index = sender.view?.tag
        presenter?.showMovieController(
            navigationController:  navigationController ?? UINavigationController(),
            enumHome: menuSection[index ?? 0]
        )
    }
}
