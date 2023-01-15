//
//  UIView+extension.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 15/01/23.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            
            if layer.masksToBounds {
                layer.shouldRasterize = true
                layer.rasterizationScale = UIScreen.main.scale
            } else {
                layer.shouldRasterize = false
            }
        }
        get {
            return layer.cornerRadius
        }
    }
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            else {
                return nil
            }
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
}
