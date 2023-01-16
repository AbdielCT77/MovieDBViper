//
//  HomeUpcomingCollectionViewCell.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 16/01/23.
//

import UIKit

class HomeUpcomingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    // MARK: - Variable -
    static let identifier = "HomeUpcomingCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "HomeUpcomingCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureData(model: MoviesModel) {
        if let path = model.posterPath {
            guard let urlImage = URL(
                string: GlobalVariables.urlImage.appending(path)
            ) else { return }
            self.movieImage.loadImageSDWeb(url: urlImage)
            self.layoutIfNeeded()
            self.movieImage.layer.cornerRadius = self.frame.height / 12.0
            self.movieImage.layer.masksToBounds = true
        }
        self.movieTitle.text = model.title
    }

}
