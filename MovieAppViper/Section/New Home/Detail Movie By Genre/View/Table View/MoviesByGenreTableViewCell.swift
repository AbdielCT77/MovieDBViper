//
//  DetailMovieByGenreTableViewCell.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 15/01/23.
//

import UIKit

class MoviesByGenreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    // MARK: - Variable -
    static let identifier = "MoviesByGenreTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "MoviesByGenreTableViewCell", bundle: nil)
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
        movieRating.text = "Rating: \(movie.voteAverage ?? 0)"
        movieTitle.text = movie.title
    }
    
}
