//
//  CardListBuilder.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 12/12/23.
//

import Foundation

class CardListBuilder {
    static func build(path: RequestPath) -> CardListViewController {
        let httpGetService = RemoteHttpGetService()
        
        let viewModel = CardListViewModel(path: path,
                                          httpGetService: httpGetService)
        let viewController = CardListViewController(viewModel: viewModel)
        viewModel.alertView = viewController
        return viewController
    }
}
