//
//  HttpGetClient.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 05/12/23.
//

import Foundation

protocol HtttpGetClientProtocol: AnyObject {
    func get(with url: URL, completion: @escaping ((Result<Data?, HttpError>) -> Void))
}
