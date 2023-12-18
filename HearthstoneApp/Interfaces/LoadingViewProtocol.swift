//
//  LoadingView.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 05/12/23.
//

import Foundation

public protocol LoadingViewProtocol: AnyObject {
    func isLoading(viewModel: LoadingViewModel)
}

public struct LoadingViewModel {
    var isLoading: Bool
    
    init(isLoading: Bool) {
        self.isLoading = isLoading
    }
}

