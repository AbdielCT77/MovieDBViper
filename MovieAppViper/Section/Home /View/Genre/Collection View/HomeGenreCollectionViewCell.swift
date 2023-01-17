//
//  HomeGenreCollectionViewCell.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 17/01/23.
//

import UIKit

class HomeGenreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var genreTitle: UILabel!
    
    // MARK: - Variable -
    static let identifier = "HomeGenreCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "HomeGenreCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureData(genre: Genres?) {
        if let genre = genre {
            genreTitle.text = genre.name
        }
    }

}
