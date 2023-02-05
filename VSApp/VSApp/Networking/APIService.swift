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


protocol ApiManagerProfileProtocol: AnyObject {
  func getProfileData(completion : @escaping (Result<Profile?, HandleError>) -> Void)
}



final class APIService: ApiManagerProductListProtocol, ApiManagerProfileProtocol {
    
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
    
    func getProfileData(completion : @escaping (Result<Profile?, HandleError>) -> Void) {
        NetworkManager.fetchData(from: sourceURLType.profileDetatil) { (result: Result<Profile?, HandleError>) in
            switch result {
            case .success(let data):
                completion(Result.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

