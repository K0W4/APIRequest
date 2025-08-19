//
//  APIRequestTests.swift
//  APIRequestTests
//
//  Created by Gabriel Kowaleski on 18/08/25.
//

@testable import APIRequest

import Testing

struct APIRequestTests {
    @Test
    func fetchProducts() async throws {
        // Given
        let service = MockProductService(shouldFail: false)
        let viewModel = HomeViewModel(service: service)
        
        // When
        await viewModel.fetchProduct(id: 1)
        await viewModel.fetchProductsByCategory(category: "category")
        await viewModel.fetchTopPicks()
        
        // Then
        #expect(viewModel.deals != nil)
        #expect(!viewModel.productsByCategories.isEmpty)
        #expect(!viewModel.topPicks.isEmpty)
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test
    func fetchProductsShouldFail() async throws {
        // Given
        let service = MockProductService(shouldFail: true)
        let viewModel = HomeViewModel(service: service)
        
        // When
        await viewModel.fetchProduct(id: 1)
        await viewModel.fetchProductsByCategory(category: "category")
        await viewModel.fetchTopPicks()
        
        // Then
        #expect(viewModel.deals == nil)
        #expect(viewModel.productsByCategories.isEmpty)
        #expect(viewModel.topPicks.isEmpty)
        #expect(viewModel.errorMessage != nil)
    }
}
