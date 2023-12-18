//
//  MainCoordinatorTests.swift
//  HearthstoneAppTests
//
//  Created by Edgar Arlindo on 14/12/23.
//

import XCTest
@testable import HearthstoneApp

final class MainCoordinatorTests: XCTestCase {
    func test_start_sets_correct_viewController() {
        let navigationController = UINavigationController()
        let sut = MainCoordinator()
        sut.navigationController = navigationController
        sut.start()
        XCTAssertTrue(navigationController.viewControllers is [LoginViewController])
    }
        
    func test_pushToSignUp_event_calls_correct_viewController() {
        let navigationController = UINavigationController()
        let sut = MainCoordinator()
        sut.navigationController = navigationController
        sut.eventOcurred(type: .pushToSignUp)
        XCTAssertTrue(navigationController.viewControllers is [SignUpViewController])
    }
        
    func test_pushToHome_event_calls_correct_viewController() {
        let navigationController = UINavigationController()
        let sut = MainCoordinator()
        sut.navigationController = navigationController
        sut.eventOcurred(type: .pushToHome)
        XCTAssertTrue(navigationController.viewControllers is [HomeViewController])
    }
    
    func test_pushToCardList_event_calls_correct_viewController() {
        let navigationController = UINavigationController()
        let sut = MainCoordinator()
        sut.navigationController = navigationController
        sut.eventOcurred(type: .pushToCardList(.init(path: "any_path")))
        XCTAssertTrue(navigationController.viewControllers is [CardListViewController])
    }
}
