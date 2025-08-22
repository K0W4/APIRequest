//
//  MockCategoryService.swift
//  APIRequestTests
//
//  Created by Gabriel Kowaleski on 22/08/25.
//

@testable import APIRequest

import Foundation

class MockCategoryService: CategoryServiceProtocol {
    var shouldFail: Bool
    var productCategory: ProductCategory
    
    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
        self.productCategory = ProductCategory(name: "Category", slug: "category")
    }
    
    func fetchCategories() async throws -> [APIRequest.ProductCategory] {
        if shouldFail {
            throw NSError(domain: #function, code: 1)
        } else {
            return [productCategory]
        }
    }
}
