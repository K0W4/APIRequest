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
    
    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
    }
    
    func fetchProduct(id: Int) async throws -> APIRequest.Product {
        if shouldFail {
            throw NSError(domain: #function, code: 1)
        } else {
            return Product(id: id, title: "title \(id)", description: "description", category: "category", price: 0.0, thumbnail: "thumbnail")
        }
    }
    
    func fetchProducts() async throws -> [APIRequest.Product] {
        if shouldFail {
            throw NSError(domain: #function, code: 2)
        } else {
            return [Product(id: 1, title: "title", description: "description", category: "category", price: 0.0, thumbnail: "thumbnail")]
        }
    }
    
    func fetchProductsByCategory(category: String) async throws -> [APIRequest.Product] {
            if shouldFail {
                throw NSError(domain: #function, code: 3)
            } else {
                return [
                    Product(id: 1, title: "title 1", description: "description", category: "category", price: 0.0, thumbnail: "thumbnail"),
                    Product(id: 2, title: "title 2", description: "description", category: "category", price: 0.0, thumbnail: "thumbnail")
                ]
            }
        }
}
