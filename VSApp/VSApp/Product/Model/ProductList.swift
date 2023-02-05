//
//  ProductList.swift
//  VSApp
//
//  Created by Binil-V on 05/02/23.
//

import Foundation

struct Product: Decodable {
  let id: String
  let brand: String?
  let name: String?
  let productDesc: String?
  let price: String?
  let offerPrice: String?
  let productUrl: String?
}

struct ProductData: Decodable {
  let products: [Product]
}

struct ProductRoot: Decodable {
  let data: ProductData
}
