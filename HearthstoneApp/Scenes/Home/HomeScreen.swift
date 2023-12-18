//
//  HomeScreen.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 06/12/23.
//

import UIKit

class HomeScreen: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var cardCategorieCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CardCategorieCell.self, forCellWithReuseIdentifier: CardCategorieCell.reuseIdentifier)
        return collectionView
    }()
    
    func reloadCollection() {
        DispatchQueue.main.async {
            self.cardCategorieCollection.reloadData()
        }
    }
    
    func setupCollectionViewProtocols(delegate: UICollectionViewDelegate,
                                      dataSource: UICollectionViewDataSource) {
        cardCategorieCollection.delegate = delegate
        cardCategorieCollection.dataSource = dataSource
    }
}

extension HomeScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(cardCategorieCollection)
    }
    
    func setupConstrains() {
        cardCategorieCollection.fillSuperview()
    }
}
