//
//  HomePopularTableViewCell.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 16/01/23.
//

import UIKit

class HomePopularTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDesc: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    
    static let identifier = "HomePopularTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "HomePopularTableViewCell", bundle: nil)
    }
    var navigationController: UINavigationController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10))
    }
    
    func configureCell(model: MoviesModel){
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
        self.movieDesc.text = model.overview
        self.movieRating.text = "\(model.voteAverage ?? 0)"
    }
    
    
    
}
