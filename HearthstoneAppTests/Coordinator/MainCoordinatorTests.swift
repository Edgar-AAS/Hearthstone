//
//  MainCoordinatorTests.swift
//  HearthstoneAppTests
//
//  Created by Edgar Arlindo on 14/12/23.
//

import XCTest
@testable import HearthstoneApp

final class MainCoordinatorTests: XCTestCase {
    func test_() {
        let navigationController = UINavigationController()
        let sut = MainCoordinator()
        sut.navigationController = navigationController
        sut.start()
        XCTAssertTrue(navigationController.viewControllers is [LoginViewController])
    }
        
    func test_3() {
        let navigationController = UINavigationController()
        let sut = MainCoordinator()
        sut.navigationController = navigationController
        sut.eventOcurred(type: .pushToSignUp)
        XCTAssertTrue(navigationController.viewControllers is [SignUpViewController])
    }
        
    func test_1() {
        let navigationController = UINavigationController()
        let sut = MainCoordinator()
        sut.navigationController = navigationController
        sut.eventOcurred(type: .pushToHome)
        XCTAssertTrue(navigationController.viewControllers is [HomeViewController])
    }
    
    func test_2() {
        let navigationController = UINavigationController()
        let sut = MainCoordinator()
        sut.navigationController = navigationController
        sut.eventOcurred(type: .pushToCardList(.init(path: "any_path")))
        XCTAssertTrue(navigationController.viewControllers is [CardListViewController])
    }
}
