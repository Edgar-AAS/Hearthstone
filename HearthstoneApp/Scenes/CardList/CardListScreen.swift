//
//  CardListScreen.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 11/12/23.
//

import UIKit

class CardListScreen: UIView {
    var alerTitle: String? {
        didSet {
            alertLabel.text = alerTitle
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var alertLabel: UILabel = {
        let label = UILabel()
        label.textColor = .tertiarySystemBackground
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .lightGray
        return label
    }()

    
    private lazy var cardCategorieCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    func reloadCollection() {
        DispatchQueue.main.async {
            self.cardCategorieCollection.reloadData()
        }
    }
    
    func setupCollectionViewProtocols(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        cardCategorieCollection.delegate = delegate
        cardCategorieCollection.dataSource = dataSource
    }
}

extension CardListScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(cardCategorieCollection)
        addSubview(alertLabel)
    }
    
    func setupConstrains() {
        cardCategorieCollection.fillSuperview()
        alertLabel.fillSuperview()
    }
}
