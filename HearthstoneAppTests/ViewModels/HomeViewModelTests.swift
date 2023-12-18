//
//  HomeViewModelTests.swift
//  HearthstoneAppTests
//
//  Created by Edgar Arlindo on 14/12/23.
//

import XCTest
@testable import HearthstoneApp

final class HomeViewModelTests: XCTestCase {
    func test_SUT_should_pass_same_URL_to_HTTPGetService() {
        let httpGetClientSpy = HttpGetClientSpy()
        let url = makeUrl()
        let sut = makeSut(httpGetServiceSpy: httpGetClientSpy, url: url)
        sut.fetchCardsCategorie {}
        XCTAssertEqual(url, httpGetClientSpy.url)
    }
    
    func test_fetchCardsCategorie_should_completes_if_httpService_succeeds() {
        let httpGetClientSpy = HttpGetClientSpy()
        let sut = makeSut(httpGetServiceSpy: httpGetClientSpy)
        
        let exp = expectation(description: "waiting")
        sut.fetchCardsCategorie {
            XCTAssert(true)
            exp.fulfill()
        }
        
        httpGetClientSpy.completeServiceWithSuccessWithValidData(data: makeValidData())
        wait(for: [exp], timeout: 1)
    }
    
    func test_goToCardListWithPath_should_call_coordinator_with_correct_EventAndData() {
        let httpGetClientSpy = HttpGetClientSpy()
        let coordinatorSpy = MainCoordinatorSpy()
        let sut: HomeViewModelProtocol = makeSut(httpGetServiceSpy: httpGetClientSpy, coordinatorSpy: coordinatorSpy)
        let path = makePath()
        sut.goToCardListWithPath(path)
        XCTAssertEqual(coordinatorSpy.methods, [.pushToCardList(path)])
    }
    
    func test_fetchCardsCategorie_fill_dataSource_with_correct_order_and_data() {
        let httpGetClientSpy = HttpGetClientSpy()
        let sut = makeSut(httpGetServiceSpy: httpGetClientSpy)
        sut.fetchCardsCategorie {}
        httpGetClientSpy.completeServiceWithSuccessWithValidData(data: makeValidData())
        
        XCTAssertEqual(sut.getCategoryCellType(index: 0), .classes(getCellCategory(index: 0)))
        XCTAssertEqual(sut.getCategoryCellType(index: 1), .races(getCellCategory(index: 1)))
        XCTAssertEqual(sut.getCategoryCellType(index: 2), .factions(getCellCategory(index: 2)))
        XCTAssertEqual(sut.getCategoryCellType(index: 3), .qualities(getCellCategory(index: 3)))
        XCTAssertEqual(sut.getCategoryCellType(index: 4), .types(getCellCategory(index: 4)))
        
    }
    
    func test_fetchCardsCategory_fills_dataSource_with_correct_quantity() {
        let httpGetClientSpy = HttpGetClientSpy()
        let sut = makeSut(httpGetServiceSpy: httpGetClientSpy)
        sut.fetchCardsCategorie {}
        httpGetClientSpy.completeServiceWithSuccessWithValidData(data: makeValidData())
        XCTAssertEqual(sut.numberOfRows, 5)
    }
    
    func test_fetchCardsCategorie_completes_with_alert_error_with_httpGetService_fails() {
        let alertViewSpy = AlertViewSpy()
        let httpGetServiceSpy = HttpGetClientSpy()
        let sut = makeSut(httpGetServiceSpy: httpGetServiceSpy, alertViewSpy: alertViewSpy)
        sut.fetchCardsCategorie {}
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Networking Fails", message: "Falha no carregamento das categorias"))
            exp.fulfill()
        }
        
        httpGetServiceSpy.completeServiceWithFailure()
        wait(for: [exp], timeout: 1)
    }
}

extension HomeViewModelTests {
    func makeSut(httpGetServiceSpy: HttpGetClientSpy = HttpGetClientSpy(),
                 coordinatorSpy: MainCoordinatorSpy = MainCoordinatorSpy(),
                 alertViewSpy: AlertViewSpy = AlertViewSpy(),
                 url: URL = makeUrl(),
                 file: StaticString = #filePath,
                 line: UInt = #line) -> HomeViewModel {
        
        let sut = HomeViewModel(httpGetService: httpGetServiceSpy,
                                coordinator: coordinatorSpy,
                                alertView: alertViewSpy,
                                url: url)
        
        checkMemoryLeak(for: httpGetServiceSpy, file: file, line: line)
        checkMemoryLeak(for: coordinatorSpy, file: file, line: line)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}

