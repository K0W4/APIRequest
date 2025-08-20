//
//  APIRequestTests.swift
//  APIRequestTests
//
//  Created by Gabriel Kowaleski on 18/08/25.
//

@testable import APIRequest

import Testing

struct HomeViewModelTests {
    @Test
    func fetchProducts() async throws {
        // Given
        let favoriteService = MockFavoriteService()
        let productService = MockProductService()
        let viewModel = HomeViewModel(favoriteService: favoriteService, productService: productService)
        
        // When
        await viewModel.fetchProducts(id: 1)
        
        // Then
        #expect(viewModel.deals != nil)
        #expect(!viewModel.topPicks.isEmpty)
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test
    func fetchProductsShouldFail() async throws {
        // Given
        let favoriteService = MockFavoriteService()
        let productService = MockProductService(shouldFail: true)
        let viewModel = HomeViewModel(favoriteService: favoriteService, productService: productService)
        
        // When
        await viewModel.fetchProducts(id: 1)
        
        // Then
        #expect(viewModel.deals == nil)
        #expect(viewModel.topPicks.isEmpty)
        #expect(viewModel.errorMessage != nil)
    }
    
    @Test
    func favorites() throws {
        // Given
        let favoriteService = MockFavoriteService()
        let productService = MockProductService()
        let viewModel = HomeViewModel(favoriteService: favoriteService, productService: productService)
        
        // When
        viewModel.favoriteTogle(id: 1)
        viewModel.favoriteTogle(id: 2)
        viewModel.favoriteTogle(id: 1)
        viewModel.refreshFavorites()
        
        // Then
        #expect(viewModel.favoriteIds.count == 1)
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test
    func favoritesFail() throws {
        // Given
        let favoriteService = MockFavoriteService(shouldFail: true)
        let productService = MockProductService()
        let viewModel = HomeViewModel(favoriteService: favoriteService, productService: productService)
        
        // When
        viewModel.favoriteTogle(id: 1)
        viewModel.favoriteTogle(id: 2)
        viewModel.favoriteTogle(id: 1)
        viewModel.refreshFavorites()
        
        // Then
        #expect(viewModel.favoriteIds.count != 1)
        #expect(viewModel.errorMessage != nil)
    }
    
    @Test
    func testSelectedProductDetails_updatesProductId() throws {
        // Given (Dado)
        let productService = MockProductService()
        let favoriteService = MockFavoriteService()
        let viewModel = HomeViewModel(favoriteService: favoriteService, productService: productService)
        
        // When (Quando)
        let testId = 99
        viewModel.selectedProductDetails(id: testId)
        
        // Then (Então)
        #expect(viewModel.selectedProductId == testId)
    }
}
