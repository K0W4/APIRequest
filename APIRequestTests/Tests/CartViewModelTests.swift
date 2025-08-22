//
//  CartViewModelTests.swift
//  APIRequestTests
//
//  Created by Gabriel Kowaleski on 22/08/25.
//

@testable import APIRequest

import Testing

struct CartViewModelTests {
    @Test
    func addProduct() throws {
        // Given
        let viewModel = CartViewModel()
        let product = Product(id: 1, title: "title", description: "description", category: "category", price: 10.0, thumbnail: "thumbnail")
        
        // When
        viewModel.addProduct(product: product)
        
        // Then
        #expect(viewModel.products.count == 1)
        #expect(viewModel.products.first?.quantity == 1)
        #expect(viewModel.totalPrice == 10.0)
        
        // When
        viewModel.addProduct(product: product)
        
        // Then
        #expect(viewModel.products.count == 1)
        #expect(viewModel.products.first?.quantity == 2)
        #expect(viewModel.totalPrice == 20.0)
    }
    
    @Test
    func removeProduct_Success() throws {
        // Given
        let viewModel = CartViewModel()
        let product = Product(id: 1, title: "title", description: "description", category: "category", price: 10.0, thumbnail: "thumbnail")
        
        // When
        viewModel.addProduct(product: product)
        viewModel.addProduct(product: product)
        viewModel.removeProduct(product: product)
        
        // Then
        #expect(viewModel.products.count == 1)
        #expect(viewModel.products.first?.quantity == 1)
        #expect(viewModel.totalPrice == 10.0)
        
        // When
        viewModel.removeProduct(product: product)
        
        // Then
        #expect(viewModel.products.isEmpty)
        #expect(viewModel.totalPrice == 0.0)
    }

    @Test
    func updateTotalPrice() throws {
        // Given
        let viewModel = CartViewModel()
        let product1 = Product(id: 1, title: "title 1", description: "description", category: "category", price: 10.0, thumbnail: "thumbnail")
        let product2 = Product(id: 2, title: "title 2", description: "description", category: "category", price: 5.0, thumbnail: "thumbnail")
        
        // When
        viewModel.addProduct(product: product1)
        viewModel.addProduct(product: product2)
        viewModel.addProduct(product: product2)
        
        // Then
        #expect(viewModel.totalPrice == 20.0)
    }

    @Test
    func selectedProductDetails_Success() throws {
        // Given
        let viewModel = CartViewModel()
        let product: Product = Product(id: 1, title: "title", description: "description", category: "category", price: 0.0, thumbnail: "thumbnail")
        
        // When
        viewModel.selectedProductDetails(product: product)
        
        // Then
        #expect(viewModel.selectedProduct == product)
    }

    @MainActor
    @Test
    func refreshCart_Success() throws {
        // Given
        let viewModel = CartViewModel()
        let product = Product(id: 1, title: "title", description: "description", category: "category", price: 10.0, thumbnail: "thumbnail")
        
        // When
        viewModel.addProduct(product: product)
        viewModel.refreshCart()
        
        // Then
        #expect(viewModel.totalPrice == 10.0)
        #expect(viewModel.viewVersion == 1)
    }
}
