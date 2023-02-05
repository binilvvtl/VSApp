//
//  ProductListViewModelTests.swift
//  VSAppTests
//
//  Created by Binil-V on 06/02/23.
//

import XCTest
import Foundation
@testable import VSApp

final class ApiManagerProductListSpy: ApiManagerProductListProtocol {
    var modelProdectList: [Product]?
    var error: HandleError?
    func getProductList(completion: @escaping (Result<[Product], VSApp.HandleError>) -> Void) {
        if let errorUnwrapped = error {
          completion(Result.failure(errorUnwrapped))
        } else {
          guard let modelUnwraped = modelProdectList else {
            completion(Result.failure(.unknown))
            return
          }
          completion(Result.success(modelUnwraped))
        }
    }

    func addStub(dataModel: [Product]?, errorType: HandleError?) {
        modelProdectList = dataModel
      error = errorType
    }
}

final class ProductListViewModelTests: XCTestCase, APIServiceCompletionProtocol {
    func didFinishFetchingProductListResponse(results: [VSApp.Product]?, error: Error?) {
        debugPrint(error)
    }
    
    func refreshTable() {
        debugPrint("")
    }
    
    var productRoot: ProductRoot?
    var productList: [Product]?
    var sut: ProductListViewModel!
    var apiServiceSpy: ApiManagerProductListSpy!
    
    override func setUp() {
        super.setUp()
        apiServiceSpy = ApiManagerProductListSpy()
        sut = ProductListViewModel(with: apiServiceSpy)
        sut.delegate = self
        productRoot = testItem(for: "ProductList")
        productList = productRoot?.data.products
    }
    
    override func tearDown() {
        sut = nil
        apiServiceSpy = nil
        super.tearDown()
    }
    
    
    func test_getProductList_Failure() {
        sut.products = []
        sut.filteredProducts = []
        apiServiceSpy.addStub(dataModel: nil, errorType: HandleError.unknown)
        sut.getProductList()
        
        XCTAssertEqual(sut.products.count, 0)
        XCTAssertEqual(sut.filteredProducts.count, 0)
        }
    
    
    func test_getProductList_Success() {
        
        
        apiServiceSpy.addStub(dataModel: productList, errorType: nil)
        sut.getProductList()
        
        XCTAssertEqual(sut.products.count, productList?.count)
        XCTAssertEqual(sut.filteredProducts[0].id, productList?.first?.id)
    }
    
    
    func test_getProduct() {
        apiServiceSpy.addStub(dataModel: productList, errorType: nil)
        sut.getProductList()
        sut.search(text: "Bombshell")
        XCTAssertEqual(sut.getProduct(index: IndexPath(item: 0, section: 0))?.id, "1")
    }
    
    
    func test_search() {
        apiServiceSpy.addStub(dataModel: productList, errorType: nil)
        sut.getProductList()
        sut.search(text: "Bombshell")
        XCTAssertEqual(sut.filteredProducts.count, 3)
        sut.search(text: "")
        XCTAssertNotEqual(sut.filteredProducts.count, 3)
    }
    
    func test_sort() {
        apiServiceSpy.addStub(dataModel: productList, errorType: nil)
        sut.getProductList()
        XCTAssertEqual(sut.getProduct(index: IndexPath(item: 8, section: 0))?.id, "9")
        sut.sort(by: .name)
        XCTAssertNotEqual(sut.getProduct(index: IndexPath(item: 8, section: 0))?.id, "9")
    }
    
}
