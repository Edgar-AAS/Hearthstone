//
//  HomeTableViewCell.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 07/12/23.
//

import UIKit

class CardCategorieCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: CardCategorieCell.self)
    private var categoriesModel: CategoryCellDTO?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    weak var delegate: CardCategorieCellProtocol?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var cardCategoryName: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private lazy var categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CardCategorieCollectionViewCell.self, forCellWithReuseIdentifier: CardCategorieCollectionViewCell.reuseIdentifier)
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    func setupCellWith(categoriesModel: CategoryCellDTO?) {
        self.categoriesModel = categoriesModel
        self.cardCategoryName.text = categoriesModel?.categorie.capitalized
        DispatchQueue.main.async {
            self.categoriesCollectionView.reloadData()
        }
    }
    
    private func makePath(category: String, subCategory: String) -> String {
        return "/\(category)/\(subCategory)".replacingOccurrences(of: " ", with: "%20")
    }
}

extension CardCategorieCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesModel?.subCategories.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCategorieCollectionViewCell.reuseIdentifier, for: indexPath) as? CardCategorieCollectionViewCell
        cell?.setupCell(with: categoriesModel?.subCategories[indexPath.item] ?? "")
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width / 3.5,
                     height: collectionView.frame.height * 0.75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = categoriesModel {
            let path = RequestPath(path: makePath(category: model.categorie,
                                                  subCategory: model.subCategories[indexPath.item]))
            delegate?.categoryDidTapped(path: path)
        }
    }
}

extension CardCategorieCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(categoriesCollectionView)
        contentView.addSubview(cardCategoryName)
    }
    
    func setupConstrains() {
        cardCategoryName.fillConstraints(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 10, left: 10, bottom: 0, right: 0))
        
        categoriesCollectionView.fillConstraints(
            top: cardCategoryName.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            bottom: contentView.bottomAnchor,
            padding: .init(top: 8, left: 0, bottom: 0, right: 0))
    }
}
