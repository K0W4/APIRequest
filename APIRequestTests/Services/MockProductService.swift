//
//  MockProductService.swift
//  APIRequestTests
//
//  Created by Gabriel Kowaleski on 18/08/25.
//

@testable import APIRequest

import Foundation

class MockProductService: ProductServiceProtocol {
    var shouldFail: Bool
    var product: Product
    
    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
        self.product = Product(id: 1, title: "title", description: "description", category: "category", price: 0.0, thumbnail: "thumbnail")
    }
    
    func fetchProduct(id: Int) async throws -> APIRequest.Product {
        if shouldFail {
            throw NSError(domain: #function, code: 1)
        } else {
            return product
        }
    }
    
    func fetchProducts() async throws -> [APIRequest.Product] {
        if shouldFail {
            throw NSError(domain: #function, code: 2)
        } else {
            return [product]
        }
    }
    
    func fechProductsByCategory(category: String) async throws -> [APIRequest.Product] {
        if shouldFail {
            throw NSError(domain: #function, code: 3)
        } else {
            return [product]
        }
    }
}
