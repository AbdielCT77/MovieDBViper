//
//  UIViewController+extension.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 15/01/23.
//

import UIKit

var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
         let spinnerView = UIView.init(frame: onView.bounds)
         spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
         let ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
         ai.startAnimating()
         ai.center = spinnerView.center
         
         DispatchQueue.main.async {
             spinnerView.addSubview(ai)
             onView.addSubview(spinnerView)
         }
         
         vSpinner = spinnerView
     }
     
    func removeSpinner() {
         DispatchQueue.main.async {
             vSpinner?.removeFromSuperview()
             vSpinner = nil
             
         }
     }
    
    func loading(){
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func hideLoading(){
        dismiss(animated: false, completion: nil)
    }
    
    func showCustomBackButton(
        imageName: String = "back",
        action: Selector? = nil,
        showLeftMargin: Bool = true
    ) {
        let backButtonSize: CGFloat = 44
        let backButton = UIButton(frame: CGRect(
            x: 0, y: 0, width: backButtonSize, height: backButtonSize
        ))
        
        backButton.setImage(UIImage(named: imageName), for: .normal)
        
        let backImageWidth = backButton.imageView?.intrinsicContentSize.width ?? 0
        
        if (showLeftMargin) {
            backButton.imageEdgeInsets = UIEdgeInsets(
                top: 0,
                left: -(backButtonSize - backImageWidth),
                bottom: 0,
                right: 0
            )
        }
        
        backButton.addTarget(self, action: {
            if let _action = action {
                return _action
            } else {
                return #selector(didTapBack(_:))
            }
        }(), for: .touchUpInside)
        
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(customView: backButton)
        ]
    }
    
    @objc private func didTapBack(_ sender: Any) {
        dismissOrPopViewController()
    }
    
    func dismissOrPopViewController(completion: (() -> Void)? = nil) {
        guard let _navigationController = navigationController else {
            return dismiss(animated: true, completion: completion)
        }
        
        _navigationController.popViewController(animated: true)
    }
}
