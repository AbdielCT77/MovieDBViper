//
//  DetailMovieCastCollectionViewCell.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 16/01/23.
//

import UIKit

class DetailMovieCastCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var castImage: UIImageView!
    @IBOutlet weak var castName: UILabel!
    
    // MARK: - Variable -
    static let identifier = "DetailMovieCastCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "DetailMovieCastCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureData(cast: Cast) {
        if let path = cast.profilePath {
            guard let urlImage = URL(
                string: GlobalVariables.urlImage.appending(path)
            ) else { return }
            self.castImage.loadImageSDWeb(url: urlImage)
            self.layoutIfNeeded()
            self.castImage.layer.masksToBounds = true
        }
        self.castName.text = cast.name
    }

}
