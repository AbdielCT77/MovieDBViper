//
//  DetailMovieByGenreViewController.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 15/01/23.
//

import UIKit

class MoviesByGenreViewController: UIViewController {
    
    // MARK: - UIVariable -
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variable -
    var presenter: MoviesByGenresViewToPresenterProtocol?
    var dataMovie: [MoviesModel] = []
    var genre: Genres?
    var currentPage: Int = 1
    var totalPage: Int = 1
    var isPageRefreshing:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        fetchPresenter()
    }
    
    private func setUI(){
        collectionView.register(
            MoviesByGenreCollectionViewCell.nib(),
            forCellWithReuseIdentifier: MoviesByGenreCollectionViewCell.identifier
        )
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func fetchPresenter(){
        guard let genre = genre else { return }
        presenter?.fetchMovies(genre: genre)
    }

}

extension MoviesByGenreViewController: MoviesByGenresPresenterToViewProtocol {
    func showMovies(data: [MoviesModel]?) {
        dataMovie = data ?? []
        collectionView.reloadData()
    }
    
    func showMoviesPaging(data: [MoviesModel]?) {
        dataMovie += data ?? []
        collectionView.reloadData()
        isPageRefreshing = false
        
    }
    
    func showError(error: BaseError) {
        print("ini errornya, ", error.getError.getDesc())
    }
    
    func isLoading(isLoading: Bool) {

    }
    
    
}

extension MoviesByGenreViewController: UICollectionViewDelegateFlowLayout,
                                       UICollectionViewDataSource{
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return dataMovie.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MoviesByGenreCollectionViewCell.identifier,
            for: indexPath
        ) as? MoviesByGenreCollectionViewCell {
            cell.configureData(dataMovie: dataMovie[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
            return CGSize(width: 120, height: 190)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        presenter?.showDetailMovieController(
            navigationController: self.navigationController ?? UINavigationController(),
            movie: dataMovie[indexPath.row].id ?? 0
        )
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(
            self.collectionView.contentOffset.y >= (
                self.collectionView.contentSize.height -
                self.collectionView.bounds.size.height
            )
        ) {
            if !isPageRefreshing {
                isPageRefreshing = true
                currentPage += 1
                if let genre = genre {
                    presenter?.fetchMoviesPaging(
                        genre: genre, page: currentPage)
                    
                }
            }
        }
    }
    
    
}
