//
//  MainCoordinatorSpy.swift
//  HearthstoneAppTests
//
//  Created by Edgar Arlindo on 04/12/23.
//

import UIKit
@testable import HearthstoneApp

class MainCoordinatorSpy: Coordinator {
    var navigationController: UINavigationController? = nil
    private (set) var methods = [Event]()
    
    func start() {}
    
    func eventOcurred(type: Event) {
        switch type {
        case .pushToHome:
            methods.append(type)
        case .pushToSignUp:
            methods.append(type)
        case .popCurrentController:
            methods.append(type)
        case .pushToCardList:
            methods.append(type)
        }
    }
}

