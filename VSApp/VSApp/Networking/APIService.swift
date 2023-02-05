//
//  APIService.swift
//  VSApp
//
//  Created by Binil-V on 05/02/23.
//

import Foundation

protocol ApiManagerProductListProtocol: AnyObject {
  func getProductList(completion : @escaping (Result<[Product]?, HandleError>) -> Void)
}



final class APIService: ApiManagerProductListProtocol {
    
    func getProductList(completion : @escaping (Result<[Product]?, HandleError>) -> Void) {
        NetworkManager.fetchData(from: sourceURLType.productList) { (result: Result<ProductRoot, HandleError>) in
            switch result {
            case .success(let data):
                completion(Result.success(data.data.products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

