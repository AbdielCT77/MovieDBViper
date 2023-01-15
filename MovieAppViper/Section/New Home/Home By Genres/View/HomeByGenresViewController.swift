//
//  HomeByGenresViewController.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 15/01/23.
//

import UIKit

class HomeByGenresViewController: UIViewController {
    
    // MARK: - UIVariable -
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Variable -
    var presenter: HomeByGenresViewToPresenterProtocol?
    var dataGenres: [Genres] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        fetchPresenter()
    }
    
    private func setUI(){
        collectionView.register(
            HomeByGenresCollectionViewCell.nib(),
            forCellWithReuseIdentifier: HomeByGenresCollectionViewCell.identifier
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
    }

    private func fetchPresenter(){
        presenter?.fetchGenres()
    }
}

extension HomeByGenresViewController: HomeByGenresPresenterToViewProtocol {
    func showGenres(data: [Genres]?) {
        dataGenres = data ?? []
        collectionView.reloadData()
    }
    
    func showError(error: BaseError) {
        print("ini error, ", error.getError.getDesc())
    }
    
    func isLoading(isLoading: Bool) {
        isLoading ? self.loading() : self.hideLoading()
    }
}

extension HomeByGenresViewController: UICollectionViewDelegateFlowLayout,
                                      UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return dataGenres.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeByGenresCollectionViewCell.identifier,
            for: indexPath
        ) as? HomeByGenresCollectionViewCell {
            cell.configureData(data: dataGenres[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        presenter?.movePageToMoviesList(
            navigationController: self.navigationController ?? UINavigationController(),
            genre: dataGenres[indexPath.row]
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 3 , height: 100)
    }
    
}

