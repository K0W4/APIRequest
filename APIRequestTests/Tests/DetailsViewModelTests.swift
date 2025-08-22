//
//  DetailsViewModelTests.swift
//  APIRequestTests
//
//  Created by Gabriel Kowaleski on 21/08/25.
//

@testable import APIRequest

import Testing

struct DetailsViewModelTests {
    @Test
    func fetchProduct_Success() async throws {
        // Given
        let productService = MockProductService()
        let favoriteService = MockFavoriteService()
        let viewModel = DetailsViewModel(favoriteService: favoriteService, productService: productService, id: 0)
        
        // When
        await viewModel.fetchProduct(id: 1)
        
        // Then
        #expect(viewModel.product != nil)
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test
    func fetchProduct_Failure() async throws {
        // Given
        let productService = MockProductService(shouldFail: true)
        let favoriteService = MockFavoriteService()
        let viewModel = DetailsViewModel(favoriteService: favoriteService, productService: productService, id: 0)
        
        // When
        await viewModel.fetchProduct(id: 1)
        
        // Then
        #expect(viewModel.product == nil)
        #expect(viewModel.errorMessage != nil)
    }
    
    @Test
    func favoriteToggle_Success() async throws {
        // Given
        let productService = MockProductService()
        let favoriteService = MockFavoriteService()
        let viewModel = DetailsViewModel(favoriteService: favoriteService, productService: productService, id: 0)
        
                
        // When - Favorit
        await viewModel.fetchProduct(id: 1)
        
        viewModel.favoriteToggle()
        
        // Then
        #expect(viewModel.isFavorite == true)
        #expect(viewModel.errorMessage == nil)
        
        // When - Unfavorite
        viewModel.favoriteToggle()
        
        // Then
        #expect(viewModel.isFavorite == false)
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test
    func favoriteToggle_Failure() async throws {
        // Given
        let productService = MockProductService()
        let favoriteService = MockFavoriteService(shouldFail: true)
        let viewModel = DetailsViewModel(favoriteService: favoriteService, productService: productService, id: 0)
        
        // When
        await viewModel.fetchProduct(id: 1)
        
        viewModel.favoriteToggle()
        
        // Then
        #expect(viewModel.isFavorite == false)
        #expect(viewModel.errorMessage != nil)
    }
    
    @Test
    func checkIsFavorite_Success() async throws {
        // Given
        let productService = MockProductService()
        let favoriteService = MockFavoriteService()
        let viewModel = DetailsViewModel(favoriteService: favoriteService, productService: productService, id: 0)

        favoriteService.favoriteIds = [1]
        
        // When
        await viewModel.fetchProduct(id: 1)
        
        // Then
        #expect(viewModel.isFavorite == true)
    }
    
    @Test
    func checkIsFavorite_Failure() async throws {
        // Given
        let productService = MockProductService()
        let favoriteService = MockFavoriteService(shouldFail: true)
        let viewModel = DetailsViewModel(favoriteService: favoriteService, productService: productService, id: 0)
            
        // When
        await viewModel.fetchProduct(id: 1)
        
        // Then
        #expect(viewModel.product != nil)
        #expect(viewModel.isFavorite == false)
        #expect(viewModel.errorMessage != nil)
    }
}
