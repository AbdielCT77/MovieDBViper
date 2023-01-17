//
//  MovieTableViewCell.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 17/01/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRatingStackView: UIStackView!
    
    
    // MARK: - Variable -
    static let identifier = "MovieTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "MovieTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureData(movie: MoviesModel) {
        if let path = movie.posterPath {
            guard let urlImage = URL(
                string: GlobalVariables.urlImage.appending(path)
            ) else { return }
            self.movieImage.loadImageSDWeb(url: urlImage)
        }
        movieRatingStackView.isHidden = true
        if let rating = movie.voteAverage {
            movieRating.text = "Rating: \(rating)"
            movieRatingStackView.isHidden = false
        }
        movieTitle.text = movie.title
    }
}
