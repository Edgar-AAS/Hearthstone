//
//  RemoteHttpGetClient.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 05/12/23.
//

import Foundation

class RemoteHttpGetService: HtttpGetClient {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func get(with url: URL, completion: @escaping ((Result<Data?, HttpError>) -> Void)) {
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.allHTTPHeaderFields = NetworkConstants.Auth.headers
        
        urlSession.dataTask(with: request as URLRequest) { data, response, error in
            if error == nil {
                guard let response = (response as? HTTPURLResponse) else { return
                    completion(.failure(.noConnectivity))
                }
                
                if let data = data {
                    switch response.statusCode {
                    case 204:
                        completion(.success(nil))
                    case 200...299:
                        completion(.success(data))
                    case 403:
                        completion(.failure(.forbidden))
                    case 400...499:
                        completion(.failure(.badRequest))
                    case 500...599:
                        completion(.failure(.serverError))
                    default:
                        completion(.failure(.noConnectivity))
                    }
                }
            } else {
                completion(.failure(.noConnectivity))
            }
        }.resume()
    }
}
