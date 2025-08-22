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
    func favoriteToggle_Success() async throws {
        // Given
        let favoriteService = MockFavoriteService()
        let viewModel = DetailsViewModel(favoriteService: favoriteService)
        
                
        // When - Favorit
        let product: Product = Product(id: 1, title: "title", description: "description", category: "category", price: 0.0, thumbnail: "thumbnail")
        
        viewModel.favoriteToggle(product: product)
        
        // Then
        #expect(viewModel.isFavorite == true)
        #expect(viewModel.errorMessage == nil)
        
        // When - Unfavorite
        viewModel.favoriteToggle(product: product)
        
        // Then
        #expect(viewModel.isFavorite == false)
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test
    func favoriteToggle_Failure() async throws {
        // Given
        let favoriteService = MockFavoriteService(shouldFail: true)
        let viewModel = DetailsViewModel(favoriteService: favoriteService)
        
        // When
        let product: Product = Product(id: 1, title: "title", description: "description", category: "category", price: 0.0, thumbnail: "thumbnail")
        
        viewModel.favoriteToggle(product: product)
        
        // Then
        #expect(viewModel.isFavorite == false)
        #expect(viewModel.errorMessage != nil)
    }
    
    @Test
    func checkIsFavorite_Success() async throws {
        // Given
        let favoriteService = MockFavoriteService()
        let viewModel = DetailsViewModel(favoriteService: favoriteService)

        favoriteService.favoriteIds = [1]
        
        // When
        let product: Product = Product(id: 1, title: "title", description: "description", category: "category", price: 0.0, thumbnail: "thumbnail")
        
        viewModel.checkIsFavorite(product: product)
        
        // Then
        #expect(viewModel.isFavorite == true)
    }
    
    @Test
    func checkIsFavorite_Failure() async throws {
        // Given
        let favoriteService = MockFavoriteService(shouldFail: true)
        let viewModel = DetailsViewModel(favoriteService: favoriteService)
            
        // When
        let product: Product = Product(id: 1, title: "title", description: "description", category: "category", price: 0.0, thumbnail: "thumbnail")
        
        viewModel.checkIsFavorite(product: product)
        
        // Then
        #expect(viewModel.isFavorite == false)
        #expect(viewModel.errorMessage != nil)
    }
}
