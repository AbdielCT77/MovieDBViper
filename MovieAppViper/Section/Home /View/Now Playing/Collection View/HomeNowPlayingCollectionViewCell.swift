//
//  HomeNowPlayingCollectionViewCell.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 14/01/23.
//

import UIKit

class HomeNowPlayingCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UIVariable -
    @IBOutlet weak var movieImage: UIImageView!
    
    // MARK: - Variable -
    static let identifier = "HomeNowPlayingCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "HomeNowPlayingCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(model: MoviesModel) {
        if let path = model.backdropPath {
            guard let urlImage = URL(
                string: GlobalVariables.urlImage.appending(path)
            ) else { return }
            self.movieImage.loadImageSDWeb(url: urlImage)
//            self.layoutIfNeeded()
//            self.movieImage.layer.cornerRadius = self.frame.height / 12.0
//            self.movieImage.layer.masksToBounds = true
        }
    }

}
