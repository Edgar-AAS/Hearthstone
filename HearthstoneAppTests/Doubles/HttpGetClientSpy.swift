//
//  HttpGetClientSpy.swift
//  HearthstoneAppTests
//
//  Created by Edgar Arlindo on 14/12/23.
//

import Foundation
@testable import HearthstoneApp

class HttpGetClientSpy: HtttpGetClientProtocol {
    private (set) var url: URL?
    private var emit: ((Result<Data?, HttpError>) -> Void)?
    
    func get(with url: URL, completion: @escaping ((Result<Data?, HttpError>) -> Void)) {
        self.url = url
        emit = completion
    }
    
    func completeServiceWithSuccessWithValidData(data: Data) {
        emit?(.success(data))
    }
    
    func completeServiceWithFailure() {
        emit?(.failure(.badRequest))
    }
}
