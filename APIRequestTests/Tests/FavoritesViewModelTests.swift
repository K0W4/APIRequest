//
//  FavoritesViewModelTests.swift
//  APIRequestTests
//
//  Created by Gabriel Kowaleski on 22/08/25.
//

@testable import APIRequest

import Testing

struct FavoritesViewModelTests {
    @Test
    func fetchFavoriteProducts_Success() async throws {
        // Given
        let favoriteService = MockFavoriteService()
        let productService = MockProductService()
        let viewModel = FavoritesViewModel(favoriteService: favoriteService, productService: productService)
        
        try favoriteService.favoriteToggle(id: 3)
        try favoriteService.favoriteToggle(id: 1)
        try favoriteService.favoriteToggle(id: 2)
        
        // When
        await viewModel.fetchFavoriteProducts()
        
        // Then
        #expect(viewModel.favorites.count == 3)
        #expect(viewModel.favorites.map { $0.id } == [1, 2, 3])
        #expect(viewModel.filteredProducts.count == 3)
        #expect(viewModel.filteredProducts.map { $0.id } == [1, 2, 3])
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test
    func fetchFavoriteProducts_Failure() async throws {
        // Given
        let favoriteService = MockFavoriteService(shouldFail: true)
        let productService = MockProductService(shouldFail: true)
        let viewModel = FavoritesViewModel(favoriteService: favoriteService, productService: productService)
        
        // When
        await viewModel.fetchFavoriteProducts()
        
        // Then
        #expect(viewModel.favorites.isEmpty)
        #expect(viewModel.filteredProducts.isEmpty)
        #expect(viewModel.errorMessage != nil)
    }
    
    @Test
    func refreshFavorites_Success() throws {
        // Given
        let favoriteService = MockFavoriteService()
        let productService = MockProductService()
        let viewModel = FavoritesViewModel(favoriteService: favoriteService, productService: productService)
                
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
        let viewModel = FavoritesViewModel(favoriteService: favoriteService, productService: productService)
                
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
        let viewModel = FavoritesViewModel(favoriteService: favoriteService, productService: productService)
                
        // When
        let testId = 1
        
        viewModel.selectedProductDetails(id: testId)
        
        // Then
        #expect(viewModel.selectedProductId == testId)
    }

    @Test
    func filterProducts() async throws {
        // Given
        let favoriteService = MockFavoriteService()
        let productService = MockProductService()
        let viewModel = FavoritesViewModel(favoriteService: favoriteService, productService: productService)

        try favoriteService.favoriteToggle(id: 1)
        try favoriteService.favoriteToggle(id: 2)


        // When
        await viewModel.fetchFavoriteProducts()
        
        viewModel.filterProducts(text: "title 1")
        
        // Then
        #expect(viewModel.filteredProducts.count == 1)
        #expect(viewModel.filteredProducts.first?.id == 1)

        // When
        viewModel.filterProducts(text: "empty")

        // Then
        #expect(viewModel.filteredProducts.isEmpty)
        
        // When
        viewModel.filterProducts(text: "")

        // Then
        #expect(viewModel.filteredProducts.count == 2)
    }
}
