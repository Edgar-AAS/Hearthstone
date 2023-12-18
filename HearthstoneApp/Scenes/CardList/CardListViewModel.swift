//
//  CardListViewModel.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 11/12/23.
//

import Foundation

protocol CardListViewModelProtocol {
    func fetchCards(completion: @escaping (() -> Void))
    func getCardDataSourceWith(item: Int) -> CardModel
    var alertView: AlertView? { get set }
    var numberOfRows: Int { get }
}

class CardListViewModel: CardListViewModelProtocol {
    private var cardsDataSource = [CardModel]()
    
    private let path: RequestPath
    private let httpGetService: HtttpGetClient
    
    init(path: RequestPath, httpGetService: HtttpGetClient) {
        self.path = path
        self.httpGetService = httpGetService
    }
    
    weak var alertView: AlertView?
    
    func getCardDataSourceWith(item: Int) -> CardModel {
        return cardsDataSource[item]
    }
    
    var numberOfRows: Int {
        return cardsDataSource.count
    }
    
    func fetchCards(completion: @escaping (() -> Void)) {
        guard let url = URL(string: NetworkConstants.Urls.baseUrl + path.path + NetworkConstants.Locales.ptBR) else { return }
        httpGetService.get(with: url) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case .success(let data):
                if var cards: [CardModel]  = data?.toModel(),
                   let cardsWithImages = self?.removeCardWithoutImage(cards: &cards) {
                    
                    DispatchQueue.main.async {
                        self?.cardsDataSource = cardsWithImages
                        completion()
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.alertView?.showMessage(viewModel: AlertViewModel(title: "", message: "Ops Algo deu errado..."))
                }
            }
        }
    }
    
    private func removeCardWithoutImage(cards: inout [CardModel]) -> [CardModel] {
        let condition: (CardModel) -> Bool = { $0.img == nil }
        cards.removeAll(where: condition)
        return cards
    }
}
