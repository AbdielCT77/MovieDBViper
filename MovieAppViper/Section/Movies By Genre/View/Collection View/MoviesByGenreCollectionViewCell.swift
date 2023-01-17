//
//  MoviesByGenreCollectionViewCell.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 17/01/23.
//

import UIKit

class MoviesByGenreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    
    // MARK: - Variable -
    static let identifier = "MoviesByGenreCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "MoviesByGenreCollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureData(dataMovie: MoviesModel?) {
        guard let data = dataMovie else { return }
        if let path = data.posterPath {
            guard let urlImage = URL(
                string: GlobalVariables.urlImage.appending(path)
            ) else { return }
            self.movieImage.loadImageSDWeb(url: urlImage)
            self.layoutIfNeeded()
            self.movieImage.layer.cornerRadius = self.frame.height / 12.0
            self.movieImage.layer.masksToBounds = true
        }
    }

}
