//
//  UIImageView+Extension.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 15/01/23.
//

import UIKit
import SDWebImage

extension UIImageView {
    func loadImageSDWeb(url : URL){
        self.sd_setImage(with: url, placeholderImage: UIImage(named: "LogoTMDB"))
    }
}
