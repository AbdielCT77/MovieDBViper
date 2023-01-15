//
//  TrendingMovieTableViewCell.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 15/01/23.
//

import UIKit

class HomeTrendingMovieTableViewCell: UITableViewCell {
    
    // MARK: - UIVariable -
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variable -
    static let identifier = "HomeTrendingMovieTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "HomeTrendingMovieTableViewCell", bundle: nil)
    }
    var presenter: ViewToPresenterProtocol?
    var data: [MoviesModel] = []
    

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(
            HomeTrendingMovieCollectionViewCell.nib(),
            forCellWithReuseIdentifier: HomeTrendingMovieCollectionViewCell.identifier
        )
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureData(model: [MoviesModel]?) {
        data = model ?? []
        collectionView.reloadData()
    }
    
}


extension HomeTrendingMovieTableViewCell: UICollectionViewDelegateFlowLayout,
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
            withReuseIdentifier: HomeTrendingMovieCollectionViewCell.identifier,
            for: indexPath
        ) as? HomeTrendingMovieCollectionViewCell {
//            cell.configure(model: data[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
            return CGSize(width: UIScreen.main.bounds.width, height: 400)
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
    
                                            
}
