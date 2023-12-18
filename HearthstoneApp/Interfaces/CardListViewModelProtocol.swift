//
//  CardListViewModelProtocol.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 18/12/23.
//

import Foundation

protocol CardListViewModelProtocol {
    func fetchCards(completion: @escaping (() -> Void))
    func getCardDataSourceWith(item: Int) -> CardModel
    var alertView: AlertViewProtocol? { get set }
    var numberOfRows: Int { get }
}
