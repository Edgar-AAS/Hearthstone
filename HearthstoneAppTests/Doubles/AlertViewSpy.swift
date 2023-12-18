//
//  AlertViewSpy.swift
//  HearthstoneAppTests
//
//  Created by Edgar Arlindo on 03/12/23.
//

import Foundation
@testable import HearthstoneApp

class AlertViewSpy: AlertViewProtocol {
    var emit: ((AlertViewModel) -> Void)?
    
    func observe(completion: @escaping (AlertViewModel) -> Void) {
        self.emit = completion
    }
    
    func showMessage(viewModel: HearthstoneApp.AlertViewModel) {
        emit?(viewModel)
    }
}
