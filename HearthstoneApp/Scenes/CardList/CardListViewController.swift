//
//  CardListViewController.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 11/12/23.
//

import UIKit

class CardListViewController: UIViewController {
    private var cardsDataSource: [CardModel] = []
    
    private let viewModel: CardListViewModelProtocol
    
    init(viewModel: CardListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var customView: CardListScreen? = {
        return view as? CardListScreen
    }()
    
    override func loadView() {
        super.loadView()
        view = CardListScreen()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle(AppNameConstants.cards)
        customView?.setupCollectionViewProtocols(delegate: self,
                                                 dataSource: self)
        viewModel.fetchCards { [weak self] in
            self?.customView?.reloadCollection()
        }
    }
}

extension CardListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.reuseIdentifier, for: indexPath) as? CardCollectionViewCell
        cell?.setupCellWith(card: viewModel.getCardDataSourceWith(item: indexPath.item))
        return cell ?? UICollectionViewCell()
    }
}

extension CardListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width / 2 - 5, height: collectionView.frame.width * 0.7)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension CardListViewController: AlertViewProtocol {
    func showMessage(viewModel: AlertViewModel) {
        self.customView?.alerTitle = viewModel.message
    }
}
