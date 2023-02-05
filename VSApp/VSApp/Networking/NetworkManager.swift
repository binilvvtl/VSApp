//
//  NetworkManager.swift
//  VSApp
//
//  Created by Binil-V on 05/02/23.
//

import Foundation

final class NetworkManager {
    static func fetchData<T: Decodable>(from urlString: String, completion: @escaping (Result<T, HandleError>) -> Void) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil else {
                    completion(.failure(.invalidData))
                    return
                }
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.jsonParsingFailure))
                }
            }.resume()
        } else {
            completion(.failure(.invalidRequest))
        }
    }
}
