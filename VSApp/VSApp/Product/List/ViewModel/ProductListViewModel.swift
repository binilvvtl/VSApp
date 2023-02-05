//
//  ProductListViewModel.swift
//  VSApp
//
//  Created by Binil-V on 05/02/23.
//

import Foundation


protocol APIServiceCompletionProtocol: NSObject {
    func didFinishFetchingProductListResponse(results: [Product]?, error: Error?)
    func refreshTable()
}

class ProductListViewModel {
    var products: [Product] = []
    var filteredProducts: [Product] = []
    
    private var apiService: ApiManagerProductListProtocol?
    weak var delegate: APIServiceCompletionProtocol?
    
    init(with service: ApiManagerProductListProtocol = APIService()) {
        apiService = service
    }
    
    func search(text: String) {
        guard text != "" else {
            filteredProducts = products
            delegate?.refreshTable()
            return
        }
        filteredProducts = products.filter {
            ($0.name ?? "").lowercased().contains(text.lowercased()) ||
            ($0.brand ?? "").lowercased().contains(text.lowercased())
        }
        delegate?.refreshTable()
    }
    
    // api call to fetch Prodict
    func getProductList() {
        apiService?.getProductList{ [weak self] response in
        switch response {
        case .success(let data):
            self?.products = data ?? []
            self?.filteredProducts = data ?? []
          self?.delegate?.didFinishFetchingProductListResponse(results: data, error: nil)
        case .failure(let error):
          self?.delegate?.didFinishFetchingProductListResponse(results: nil, error: error)
        }
      }
    }
    
    func sort(by field: SortField) {
        filteredProducts = filteredProducts.sorted {
            switch field {
            case .name:
                return ($0.name ?? "" ).lowercased() < ($1.name ?? "" ).lowercased()
            case .brand:
                return ($0.brand ?? "").lowercased() < ($1.brand ?? "").lowercased()
            case .price:
                return Double($0.price ?? "0")! < Double($1.price ?? "0")!
            case .offerPrice:
                return Double($0.offerPrice ?? "0")! < Double($1.offerPrice ?? "0")!
            }
        }
        delegate?.refreshTable()
    }
    
    func getProduct(index: IndexPath) -> Product? {
        return products[safe: index.row]
    }
}

enum SortField {
  case name, brand, price, offerPrice
}

