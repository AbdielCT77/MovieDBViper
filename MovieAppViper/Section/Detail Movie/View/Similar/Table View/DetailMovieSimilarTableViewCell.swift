//
//  DetailMovieSimilarTableViewCell.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 16/01/23.
//

import UIKit

class DetailMovieSimilarTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Variable -
    static let identifier = "DetailMovieSimilarTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "DetailMovieSimilarTableViewCell", bundle: nil)
    }
    var navigationController: UINavigationController?
    var dataSimilar: [MoviesModel] = []
    var presenter: DetailMovieViewToPresenterProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(
            DetailMovieSimilarCollectionViewCell.nib(),
            forCellWithReuseIdentifier: DetailMovieSimilarCollectionViewCell.identifier
        )
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureData(model: [MoviesModel]?) {
        dataSimilar = model ?? []
        collectionView.reloadData()
    }
    
}

extension DetailMovieSimilarTableViewCell: UICollectionViewDelegateFlowLayout,
                                        UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return dataSimilar.count
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DetailMovieSimilarCollectionViewCell.identifier,
            for: indexPath
        ) as? DetailMovieSimilarCollectionViewCell {
            cell.configureData(model: dataSimilar[indexPath.row])
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
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        presenter?.showDetailMovieFromSimilarController(
            navigationController: self.navigationController ?? UINavigationController(),
            movie: dataSimilar[indexPath.row].id ?? 0
        )
    }
    
    
    
}

