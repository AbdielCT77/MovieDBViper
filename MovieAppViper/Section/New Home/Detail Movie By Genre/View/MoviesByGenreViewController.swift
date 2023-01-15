//
//  DetailMovieByGenreViewController.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 15/01/23.
//

import UIKit

class MoviesByGenreViewController: UIViewController {
    
    // MARK: - UIVariable -
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variable -
    var presenter: MoviesByGenresViewToPresenterProtocol?
    var dataMovie: [MoviesModel] = []
    var genre: Genres?
    var currentPage: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        fetchPresenter()
    }
    
    private func setUI(){
        tableView.register(
            MoviesByGenreTableViewCell.nib(),
            forCellReuseIdentifier: MoviesByGenreTableViewCell.identifier
        )
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchPresenter(){
        guard let genre = genre else { return }
        presenter?.fetchMovies(genre: genre)
    }

}

extension MoviesByGenreViewController: MoviesByGenresPresenterToViewProtocol {
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
//        isLoading ? self.loading() : self.hideLoading()
    }
    
    
}

extension MoviesByGenreViewController: UITableViewDelegate,
                                       UITableViewDataSource{
    
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
            withIdentifier: MoviesByGenreTableViewCell.identifier,
            for: indexPath
        ) as? MoviesByGenreTableViewCell {
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
            spinner.frame = CGRect(x: 0.0, y: 0.0, width: self.tableView.bounds.width, height: 70)
            spinner.startAnimating()
            if let genre = genre {
                presenter?.fetchMoviesPaging(genre: genre, page: currentPage)
            }
            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
        }
    }
    
    
}
