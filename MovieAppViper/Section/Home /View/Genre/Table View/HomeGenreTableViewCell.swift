//
//  HomeGenreTableViewCell.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 17/01/23.
//

import UIKit

class HomeGenreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variable -
    static let identifier = "HomeGenreTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "HomeGenreTableViewCell", bundle: nil)
    }
    var presenter: ViewToPresenterProtocol?
    var navigationController: UINavigationController?
    
    var data: [Genres] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(
            HomeGenreCollectionViewCell.nib(),
            forCellWithReuseIdentifier: HomeGenreCollectionViewCell.identifier
        )
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureData(genre: [Genres]?) {
        guard let genre = genre else { return }
        data = genre
        collectionView.reloadData()
    }
}

extension HomeGenreTableViewCell: UICollectionViewDelegateFlowLayout,
                                    UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return data.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeGenreCollectionViewCell.identifier,
            for: indexPath
        ) as? HomeGenreCollectionViewCell {
            cell.configureData(genre: data[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
            return CGSize(width: 150, height: 50)
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
        presenter?.showMovieByGenreController(
            navigationController: self.navigationController ?? UINavigationController(),
            genre: data[indexPath.row]
        )
    }
    
}
