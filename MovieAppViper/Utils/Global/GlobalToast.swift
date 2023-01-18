//
//  GlobalToast.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 18/01/23.
//

import UIKit

class GlobalToast: UIView {
    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    
    var image: String = "" {
        didSet {
            guard let _image = imageView else { return }
            _image.image = UIImage(named: image)
        }
    }
    
    var title: String = "" {
        didSet {
            guard let _titleLabel = titleLabel else { return }
            _titleLabel.text = title
        }
    }
    
    var subtitle: String = "" {
        didSet {
            guard let _subtitleLabel = subtitleLabel else { return }
            _subtitleLabel.text = subtitle
        }
    }
    
    var hexString: String = ""{
        didSet {
            layer.borderColor = GlobalVariables.hexStringToUIColor(
                hexString
            ).cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = GlobalVariables.hexStringToUIColor(
            "#9ca0a3"
        ).cgColor
        
        imageView = UIImageView()
        
        titleLabel = UILabel()
        titleLabel.text = ""
        titleLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        titleLabel.textColor = .black
        
        subtitleLabel = UILabel()
        subtitleLabel.text = ""
        subtitleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        subtitleLabel.textColor = .black
        
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 16),
            imageView.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: 20
            ),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        let uiStackView = UIStackView()
        uiStackView.axis = .vertical
        uiStackView.alignment = .fill
        uiStackView.distribution = .fillEqually
        uiStackView.spacing = 4
        
        uiStackView.addArrangedSubview(titleLabel)
        uiStackView.addArrangedSubview(subtitleLabel)
        
        addSubview(uiStackView)
        uiStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            uiStackView.leadingAnchor.constraint(
                equalTo: imageView.trailingAnchor, constant: 20
            ),
            uiStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            uiStackView.centerYAnchor.constraint(
                equalTo: imageView.centerYAnchor
            )
        ])
    }
}

