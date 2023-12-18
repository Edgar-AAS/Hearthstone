//
//  MainCoordinator.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 04/12/23.
//

import UIKit

enum Event: Equatable {
    case pushToSignUp
    case pushToHome
    case popCurrentController
    case pushToCardList(RequestPath)

    static func == (lhs: Event, rhs: Event) -> Bool {
        switch (lhs, rhs) {
        case (.pushToSignUp, .pushToSignUp),
             (.pushToHome, .pushToHome),
             (.popCurrentController, .popCurrentController):
            return true
        case let (.pushToCardList(lhsPath), .pushToCardList(rhsPath)):
            return lhsPath == rhsPath
        default:
            return false
        }
    }
}


protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? { get set }
    func start()
    func eventOcurred(type: Event)
}

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func start() {
        let viewController = SignInBuilder.build(coordinator: self)
        navigationController?.setViewControllers([viewController], animated: true)
    }
        
    func eventOcurred(type: Event) {
        switch type {
        case .pushToSignUp:
            let viewController = SignUpBuilder.build(coordinator: self)
            navigationController?.pushViewController(viewController, animated: true)
        case .pushToHome:
            let viewController = HomeBuilder.build(coordinator: self)
            navigationController?.pushViewController(viewController, animated: true)
        case .popCurrentController:
            navigationController?.popViewController(animated: true)
        case .pushToCardList(let path):
            let viewController = CardListBuilder.build(path: path)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
