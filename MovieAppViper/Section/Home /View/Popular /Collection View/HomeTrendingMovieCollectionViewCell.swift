//
//  HomeTrendingMovieCollectionViewCell.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 15/01/23.
//

import UIKit

class HomeTrendingMovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variable -
    static let identifier = "HomeTrendingMovieCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "HomeTrendingMovieCollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
