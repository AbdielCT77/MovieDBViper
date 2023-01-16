//
//  HomeUpcomingTableViewCell.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 16/01/23.
//

import UIKit

class HomeUpcomingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    static let identifier = "HomeUpcomingTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "HomeUpcomingTableViewCell", bundle: nil)
    }
    var presenter: ViewToPresenterProtocol?
    var data: [MoviesModel] = []
    var navigationController: UINavigationController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(
            HomeUpcomingCollectionViewCell.nib(),
            forCellWithReuseIdentifier: HomeUpcomingCollectionViewCell.identifier
        )
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureData(model: [MoviesModel]?) {
        data = model ?? []
        collectionView.reloadData()
    }
    
}

extension HomeUpcomingTableViewCell: UICollectionViewDelegateFlowLayout,
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
            withReuseIdentifier: HomeUpcomingCollectionViewCell.identifier,
            for: indexPath
        ) as? HomeUpcomingCollectionViewCell {
            cell.configureData(model: data[indexPath.row])
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
        presenter?.showDetailMovieController(
            navigationController: self.navigationController ?? UINavigationController(),
            movie: data[indexPath.row].id ?? 0
        )
    }
}
