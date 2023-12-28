//
//  HomeViewController.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 05/12/23.
//

import UIKit

class HomeViewController: UIViewController {
    var viewModel: HomeViewModelProtocol?
    
    private lazy var customView: HomeScreen? = {
        return view as? HomeScreen
    }()
    
    override func loadView() {
        super.loadView()
        view = HomeScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle(AppNameConstants.categories)
        hideNavigationBackButton()
        customView?.setupCollectionViewProtocols(delegate: self, dataSource: self)
        viewModel?.fetchCardsCategorie { [weak self] in self?.customView?.reloadCollection() }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfRows ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCategorieCell.reuseIdentifier, for: indexPath) as? CardCategorieCell
        cell?.delegate = self
        guard let type = viewModel?.getCategoryCellType(index: indexPath.row) else { return UICollectionViewCell() }
        
        var categoryData: CategoryCellDTO?
        
        switch type {
            case .classes(let classesModel): categoryData = classesModel
            case .races(let racesModel): categoryData = racesModel
            case .qualities(let qualitiesModel): categoryData = qualitiesModel
            case .factions(let factionsModel): categoryData = factionsModel
            case .types(let typesModel): categoryData = typesModel
        }
        
        cell?.setupCellWith(categoriesModel: categoryData)
        return cell ?? UICollectionViewCell()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.width * 0.45)
    }
}

extension HomeViewController: CardCategorieCellProtocol {
    func categoryDidTapped(path: RequestPath) {
        viewModel?.goToCardListWithPath(path)
    }
}

extension HomeViewController: AlertViewProtocol {
    func showMessage(viewModel: AlertViewModel) {
        print(viewModel.message)
    }
}
