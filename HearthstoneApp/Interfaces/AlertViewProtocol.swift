//
//  AlertView.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 01/12/23.
//

import Foundation

public protocol AlertViewProtocol: AnyObject {
    func showMessage(viewModel: AlertViewModel)
}

public struct AlertViewModel: Equatable {
    public let title: String
    public let message: String
    
    public init(title: String, message: String) {
        self.title = title
        self.message = message
    }
}

