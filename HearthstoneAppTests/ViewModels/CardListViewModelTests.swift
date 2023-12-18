//
//  CardListViewModelTests.swift
//  HearthstoneAppTests
//
//  Created by Edgar Arlindo on 18/12/23.
//

import XCTest
@testable import HearthstoneApp


final class CardListViewModelTests: XCTestCase {
    func test_fetchCards_pass_the_same_path_to_url() {
        let path = RequestPath(path: "any/path")
        let httpGetServiceSpy = HttpGetClientSpy()
        let sut = makeSut(httpGetServiceSpy: httpGetServiceSpy)
        sut.fetchCards { }
        let expectedUrl = URL(string: NetworkConstants.Urls.baseUrl + path.path + NetworkConstants.Locales.ptBR)!
        XCTAssertEqual(httpGetServiceSpy.url, expectedUrl)
    }
    
    func test_fetchCards_should_fill_dataSource_with_correct_data() {
        let httpGetServiceSpy = HttpGetClientSpy()
        let sut = makeSut(httpGetServiceSpy: httpGetServiceSpy)
        let exp = expectation(description: "waiting")
        sut.fetchCards {
            XCTAssertEqual(sut.getCardDataSourceWith(item: 0), makeCarModel())
            exp.fulfill()
        }
        httpGetServiceSpy.completeServiceWithSuccessWithValidData(data: makeCardData())
        wait(for: [exp], timeout: 1)
    }
    
    func test_fetchCards_update_dataSource_with_correct_quantity() {
        let httpGetServiceSpy = HttpGetClientSpy()
        let sut = makeSut(httpGetServiceSpy: httpGetServiceSpy)
        let exp = expectation(description: "waiting")
        sut.fetchCards {
            XCTAssertEqual(sut.numberOfRows, 1)
            exp.fulfill()
        }
        httpGetServiceSpy.completeServiceWithSuccessWithValidData(data: makeCardData())
        wait(for: [exp], timeout: 1)
    }
    
    func test_fetchCards_should_call_alert_error_if_httpGetService_fails() {
        let httpGetServiceSpy = HttpGetClientSpy()
        let sut = CardListViewModel(path: makePath(), httpGetService: httpGetServiceSpy)
        sut.fetchCards {}
        
        let alertViewSpy = AlertViewSpy()
        sut.alertView = alertViewSpy
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "", message: "Ops Algo deu errado..."))
            exp.fulfill()
        }
        httpGetServiceSpy.completeServiceWithFailure()
        wait(for: [exp], timeout: 1)
    }
}

extension CardListViewModelTests {
    func makeSut(httpGetServiceSpy: HttpGetClientSpy = HttpGetClientSpy(),
                 path: RequestPath = makePath()) -> CardListViewModel {
        let sut = CardListViewModel(path: path, httpGetService: httpGetServiceSpy)
        return sut
    }
}
