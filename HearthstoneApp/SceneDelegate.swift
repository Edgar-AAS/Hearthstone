//
//  SceneDelegate.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 01/12/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let coordinator = MainCoordinator()
        let navigationController = UINavigationController()
        coordinator.navigationController = navigationController
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        coordinator.start()
    }
}

