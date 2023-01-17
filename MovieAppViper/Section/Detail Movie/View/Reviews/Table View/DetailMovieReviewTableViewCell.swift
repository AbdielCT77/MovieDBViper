//
//  DetailMovieReviewTableViewCell.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 17/01/23.
//

import UIKit

class DetailMovieReviewTableViewCell: UITableViewCell {
    
    // MARK: - UI Variable -
    
    @IBOutlet weak var reviewerImage: UIImageView!
    @IBOutlet weak var reviewerName: UILabel!
    @IBOutlet weak var reviewerRating: UILabel!
    @IBOutlet weak var reviewerContent: UITextView!
    @IBOutlet weak var reviewerContentHeight: NSLayoutConstraint!
    
    
    // MARK: - Variable -
    static let identifier = "DetailMovieReviewTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "DetailMovieReviewTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureDetailMovie(review: ReviewsResult?){
        guard let review = review else { return }
        reviewerName.text = review.author
        reviewerRating.text = "\(review.authorDetails?.rating ?? 0)"
        reviewerContent.text = review.content
        reviewerContentHeight.constant = reviewerContent.contentSize.height
        if let path = review.authorDetails?.avatarPath {
            guard let urlImage = URL(
                string: GlobalVariables.urlImage.appending(path)
            ) else { return }
            self.reviewerImage.loadImageSDWeb(url: urlImage)
            self.layoutIfNeeded()
            self.reviewerImage.layer.masksToBounds = true
        }
        
    }
    
}
