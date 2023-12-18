//
//  LoadingViewSpy.swift
//  HearthstoneAppTests
//
//  Created by Edgar Arlindo on 05/12/23.
//

import Foundation
@testable import HearthstoneApp

class LoadingViewSpy: LoadingView {
    private(set) var emit: ((LoadingViewModel) -> Void)?
    
    func observe(completion: @escaping (LoadingViewModel) -> Void) {
        self.emit = completion
    }
    
    func isLoading(viewModel: LoadingViewModel) {
        emit?(viewModel)
    }
}
