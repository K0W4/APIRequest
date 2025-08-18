//
//  APIRequestTests.swift
//  APIRequestTests
//
//  Created by Gabriel Kowaleski on 18/08/25.
//

@testable import APIRequest

import Testing

struct APIRequestTests {
    @Test func fetchProducts() async throws {
        // Given
        let service = MockProductService(souldFail: false)
        let viewModel = ProductViewModel(service: service)
        
        // When
        await viewModel.loadProducts()
        
        // Then
        #expect(!viewModel.products.isEmpty)
        #expect(viewModel.product != nil)
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test func fetchProductsShouldFail() async throws {
        // Given
        let service = MockProductService(souldFail: true)
        let viewModel = ProductViewModel(service: service)
        
        // When
        await viewModel.loadProducts()
        
        // Then
        #expect(viewModel.products.isEmpty)
        #expect(viewModel.product == nil)
        #expect(viewModel.errorMessage != nil)
    }
}
