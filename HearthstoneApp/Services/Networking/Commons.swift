//
//  Commons.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 05/12/23.
//

import Foundation

enum HttpError: Error {
    case noConnectivity
    case badRequest
    case serverError
    case forbidden
    case badUrl
}
