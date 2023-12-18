//
//  HomeBuilder.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 07/12/23.
//

import Foundation

class HomeBuilder {
    static func build(coordinator: Coordinator) -> HomeViewController {
        let httpGetService = RemoteHttpGetService()
        let viewController = HomeViewController()
        let viewModel = HomeViewModel(httpGetService: httpGetService,
                                      coordinator: coordinator,
                                      alertView: viewController,
                                      url: URL(string: NetworkConstants.Urls.cardInfos)!)
        viewController.viewModel = viewModel
        return viewController
    }
}
