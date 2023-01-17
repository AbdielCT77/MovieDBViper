//
//  MoviesViewController.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 17/01/23.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variable -
    var presenter: MoviesViewToPresenterProtocol?
    var enumHome: HomeEnumSection?
    var currentPage: Int = 1
    var dataMovie: [MoviesModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        fetchPresenter()
        
    }
    
    private func setUI(){
        tableView.register(
            MovieTableViewCell.nib(),
            forCellReuseIdentifier: MovieTableViewCell.identifier
        )
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchPresenter(){
        guard let enumHome = enumHome else { return }
        presenter?.fetchMovies(homeEnum: enumHome)
    }

}

extension MoviesViewController: MoviesPresenterToViewProtocol {
    func showMovies(data: [MoviesModel]?) {
        dataMovie = data ?? []
        tableView.reloadData()
    }
    
    func showMoviesPaging(data: [MoviesModel]?) {
        dataMovie += data ?? []
        tableView.reloadData()
        tableView.tableFooterView?.isHidden = true
    }
    
    func showError(error: BaseError) {
        print("ini errornya, ", error.getError.getDesc())
    }
    
    func isLoading(isLoading: Bool) {
        
    }
    
    
}

extension MoviesViewController: UITableViewDelegate,
                                UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return dataMovie.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: MovieTableViewCell.identifier,
            for: indexPath
        ) as? MovieTableViewCell {
            cell.configureData(movie: dataMovie[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func scrollViewDidScroll(
        _ scrollView: UIScrollView
    ) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height-100-scrollView.frame.size.height){
            self.currentPage += 1
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.frame = CGRect(
                x: 0.0, y: 0.0, width: self.tableView.bounds.width, height: 70
            )
            spinner.startAnimating()
            if let enumHome = enumHome {
                presenter?.fetchMoviesPaging(homeEnum: enumHome, page: currentPage)
            }
            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
        }
    }
    
    
}
