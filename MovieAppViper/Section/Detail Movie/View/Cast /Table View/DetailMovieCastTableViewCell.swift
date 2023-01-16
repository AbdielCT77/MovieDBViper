//
//  DetailMovieCastTableViewCell.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 16/01/23.
//

import UIKit

class DetailMovieCastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variable -
    static let identifier = "DetailMovieCastTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "DetailMovieCastTableViewCell", bundle: nil)
    }
    var dataCast: [Cast] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(
            DetailMovieCastCollectionViewCell.nib(),
            forCellWithReuseIdentifier: DetailMovieCastCollectionViewCell.identifier
        )
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureData(cast: [Cast]?) {
        dataCast = cast ?? []
        collectionView.reloadData()
    }
    
}

extension DetailMovieCastTableViewCell: UICollectionViewDelegateFlowLayout,
                                        UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return dataCast.count
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DetailMovieCastCollectionViewCell.identifier,
            for: indexPath
        ) as? DetailMovieCastCollectionViewCell {
            cell.configureData(cast: dataCast[indexPath.row])
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
    
    
    
}
