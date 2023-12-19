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
    
    private lazy var refreshControll: UIRefreshControl = {
        let refreshControll = UIRefreshControl()
        refreshControll.addTarget(self, action: #selector(reloadCollection), for: .valueChanged)
        return refreshControll
    }()
    
    private lazy var cardCategorieCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CardCategorieCell.self, forCellWithReuseIdentifier: CardCategorieCell.reuseIdentifier)
        collectionView.refreshControl = refreshControll
        return collectionView
    }()
    
    @objc func reloadCollection() {
        DispatchQueue.main.async {
            self.cardCategorieCollection.reloadData()
            self.refreshControll.endRefreshing()
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
