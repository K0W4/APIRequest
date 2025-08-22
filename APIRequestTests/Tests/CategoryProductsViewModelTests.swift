//
//  CategoryProductsViewModelTests.swift
//  APIRequestTests
//
//  Created by Gabriel Kowaleski on 22/08/25.
//

@testable import APIRequest

import Testing

struct CategoryProductsViewModelTests {
    @Test
    func fetchProductsByCategorys_Success() async throws {
        // Given
        let favoriteService = MockFavoriteService()
        let productService = MockProductService()
        let viewModel = CategoryProductsViewModel(favoriteService: favoriteService, productService: productService)
        
        // When
        await viewModel.fetchProductsByCategory(category: ProductCategory(name: "name", slug: "slug"))
        
        // Then
        #expect(viewModel.categoryProducts.isEmpty == false)
        #expect(viewModel.filteredProducts.isEmpty == false)
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test
    func fetchProductsByCategory_Failure() async throws {
        // Given
        let favoriteService = MockFavoriteService()
        let productService = MockProductService(shouldFail: true)
        let viewModel = CategoryProductsViewModel(favoriteService: favoriteService, productService: productService)
        
        // When
        await viewModel.fetchProductsByCategory(category: ProductCategory(name: "name", slug: "slug"))
        
        // Then
        #expect(viewModel.categoryProducts.isEmpty)
        #expect(viewModel.filteredProducts.isEmpty)
        #expect(viewModel.errorMessage != nil)
    }
    
    @Test
    func favoriteToggle_Success() throws {
        // Given
        let favoriteService = MockFavoriteService()
        let productService = MockProductService()
        let viewModel = CategoryProductsViewModel(favoriteService: favoriteService, productService: productService)
                
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
        let viewModel = CategoryProductsViewModel(favoriteService: favoriteService, productService: productService)
        
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
        let viewModel = CategoryProductsViewModel(favoriteService: favoriteService, productService: productService)
                
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
        let viewModel = CategoryProductsViewModel(favoriteService: favoriteService, productService: productService)
                
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
        let viewModel = CategoryProductsViewModel(favoriteService: favoriteService, productService: productService)
                
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
        let viewModel = CategoryProductsViewModel(favoriteService: favoriteService, productService: productService)

        try favoriteService.favoriteToggle(id: 1)
        try favoriteService.favoriteToggle(id: 2)


        // When
        await viewModel.fetchProductsByCategory(category: ProductCategory(name: "name", slug: "slug"))
        
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
