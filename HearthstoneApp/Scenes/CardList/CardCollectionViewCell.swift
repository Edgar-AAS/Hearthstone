//
//  CardCollectionViewCell.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 12/12/23.
//

import UIKit
import Kingfisher

class CardCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: CardCollectionViewCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        return indicator
    }()

    private lazy var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        activityIndicator.startAnimating()
    }
    
    func setupCellWith(card: CardModel) {
        if let urlImageString = card.img,
           let urlImage = URL(string: urlImageString) {
            cardImageView.kf.setImage(with: urlImage) { [weak self] result in
                switch result {
                case .success:
                    self?.activityIndicator.stopAnimating()
                case .failure: return
                }
            }
        }
    }
}

extension CardCollectionViewCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(cardImageView)
        contentView.addSubview(activityIndicator)
    }
    
    func setupConstrains() {
        cardImageView.fillSuperview()
        activityIndicator.superviewCenter()
    }
}
