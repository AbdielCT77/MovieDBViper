//
//  GenresMovieTableViewCell.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 15/01/23.
//

import UIKit

class GenresMovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var genreTitle: UILabel!
    
    // MARK: - Variable -
    static let identifier = "GenresMovieTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "GenresMovieTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
