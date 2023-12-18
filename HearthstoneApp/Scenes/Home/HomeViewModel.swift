//
//  HomeViewModel.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 06/12/23.
//

import Foundation

protocol HomeViewModelProtocol {
    func fetchCardsCategorie(completion: @escaping (() -> Void))
    func goToCardListWithPath(_ path: RequestPath)
    var numberOfRows: Int { get }
    func getCategoryCellType(index: Int) -> CategoryCellDataSource
}

class HomeViewModel: HomeViewModelProtocol {
    private let httpGetService: HtttpGetClient
    private var cellTypeDataSource = [CategoryCellDataSource]()
    private let coordinator: Coordinator
    private weak var alertView: AlertView?
    private let url: URL
    
    init(httpGetService: HtttpGetClient,
         coordinator: Coordinator,
         alertView: AlertView,
         url: URL) {
        
        self.httpGetService = httpGetService
        self.coordinator = coordinator
        self.alertView = alertView
        self.url = url
    }
    
    var numberOfRows: Int {
        return cellTypeDataSource.count
    }
    
    func getCategoryCellType(index: Int) -> CategoryCellDataSource {
        return cellTypeDataSource[index]
    }
    
    func goToCardListWithPath(_ path: RequestPath) {
        coordinator.eventOcurred(type: .pushToCardList(path))
    }
        
    func fetchCardsCategorie(completion: @escaping (() -> Void)) {
        httpGetService.get(with: url) { [weak self] result in
            switch result {
            case .success(let data):
                if let categories: CardCategorieModel = data?.toModel() {
                    self?.cellTypeDataSource = [
                        .classes(.init(subCategories: categories.classes ?? [], categorie: CategoryStringsPath.classes)),
                        .races(.init(subCategories: categories.races ?? [], categorie: CategoryStringsPath.races)),
                        .factions(.init(subCategories: categories.factions ?? [], categorie: CategoryStringsPath.factions)),
                        .qualities(.init(subCategories: categories.qualities ?? [], categorie: CategoryStringsPath.qualities)),
                        .types(.init(subCategories: categories.types ?? [], categorie: CategoryStringsPath.types))
                    ]
                    completion()
                }
            case .failure:
                self?.alertView?.showMessage(viewModel: AlertViewModel(title: "Networking Fails", message: "Falha no carregamento das categorias"))
            }
        }
    }
}
