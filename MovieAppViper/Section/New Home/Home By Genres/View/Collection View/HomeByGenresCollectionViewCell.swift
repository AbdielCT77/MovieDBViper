//
//  HomeByGenresCollectionViewCell.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 15/01/23.
//

import UIKit

class HomeByGenresCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UIVariable -
    @IBOutlet weak var genreTitle: UILabel!
    
    // MARK: - Variable -
    static let identifier = "HomeByGenresCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "HomeByGenresCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureData(data: Genres) {
        genreTitle.text = data.name
    }

}
