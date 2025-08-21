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
    func fetchProducts_Success() async throws {
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
    func fetchProducts_Failure() async throws {
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
    func favoriteToggle_Success() throws {
        // Given
        let favoriteService = MockFavoriteService()
        let productService = MockProductService()
        let viewModel = HomeViewModel(favoriteService: favoriteService, productService: productService)
                
        // When: 1º favorit
        viewModel.favoriteToggle(id: 1)
        
        // Then
        #expect(viewModel.favoriteIds.count == 1)
        #expect(viewModel.favoriteIds.contains(1))
        
        // When: 2º favorit
        viewModel.favoriteToggle(id: 2)
        
        // Then
        #expect(viewModel.favoriteIds.count == 2)
        
        // When: Remove the first
        viewModel.favoriteToggle(id: 1)
        
        // Then
        #expect(viewModel.favoriteIds.count == 1)
        #expect(viewModel.favoriteIds.contains(2))
    }
    
    @Test
    func favoriteToggle_Failure() throws {
        // Given
        let favoriteService = MockFavoriteService(shouldFail: true)
        let productService = MockProductService()
        let viewModel = HomeViewModel(favoriteService: favoriteService, productService: productService)
        
        // When
        viewModel.favoriteToggle(id: 1)
        
        // Then
        #expect(viewModel.favoriteIds.isEmpty)
        #expect(viewModel.errorMessage != nil)
    }

    @Test
    func refreshFavorites_Success() throws {
        // Given
        let favoriteService = MockFavoriteService()
        let productService = MockProductService()
        let viewModel = HomeViewModel(favoriteService: favoriteService, productService: productService)
                
        // When
        try favoriteService.favoriteToggle(id: 1)
        
        viewModel.refreshFavorites()
        
        // Then
        #expect(viewModel.favoriteIds.count == 1)
        #expect(viewModel.favoriteIds.contains(1))
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test
    func refreshFavorites_Failure() throws {
        // Given
        let favoriteService = MockFavoriteService(shouldFail: true)
        let productService = MockProductService()
        let viewModel = HomeViewModel(favoriteService: favoriteService, productService: productService)
                
        // When
        viewModel.refreshFavorites()
        
        // Then
        #expect(viewModel.favoriteIds.isEmpty)
        #expect(viewModel.errorMessage != nil)
    }
    
    @Test
    func selectedProductDetails() throws {
        // Given
        let productService = MockProductService()
        let favoriteService = MockFavoriteService()
        let viewModel = HomeViewModel(favoriteService: favoriteService, productService: productService)
                
        // When
        let testId = 99
        viewModel.selectedProductDetails(id: testId)
        
        // Then
        #expect(viewModel.selectedProductId == testId)
    }
}
