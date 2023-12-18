//
//  CardCollectionViewCell.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 07/12/23.
//

import UIKit
import Kingfisher

class CardCategorieCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: CardCategorieCollectionViewCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var iconImageView: UIView  = {
        let view = UIImageView()
        view.backgroundColor = .purple
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var categorieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.baselineAdjustment = .alignBaselines
        return label
    }()
    
    func setupCell(with cardCategory: String) { 
        categorieNameLabel.text = cardCategory
    }
}

extension CardCategorieCollectionViewCell: CodeView {
    func buildViewHierarchy() {
        addSubview(iconImageView)
        iconImageView.addSubview(categorieNameLabel)
    }
    
    func setupConstrains() {
        
        let padding: CGFloat = 8.0
        
        iconImageView.fillConstraints(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            padding: .init(top: padding, left: 0, bottom: padding, right: 0)
        )
        
        NSLayoutConstraint.activate([
            categorieNameLabel.topAnchor.constraint(greaterThanOrEqualTo: iconImageView.topAnchor, constant: padding),
            categorieNameLabel.leadingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: padding),
            categorieNameLabel.trailingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: -padding),
            categorieNameLabel.bottomAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: -padding)
        ])
    }
    
    func setupAdditionalConfiguration() {
        iconImageView.makeShadow()
        iconImageView.backgroundColor = .random()
    }
}
