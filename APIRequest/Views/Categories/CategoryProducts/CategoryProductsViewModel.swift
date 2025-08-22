//
//  CategoryProductsViewModel.swift
//  APIRequest
//
//  Created by Gabriel Barbosa on 21/08/25.
//

import Foundation
import SwiftUI

@Observable
class CategoryProductsViewModel {
    var category: ProductCategory?
    var categoryProducts: [Product] = []
    var selectedProductId: Int? = nil
    var favoriteIds: [Int] = []
    var isLoading: Bool = false
    var errorMessage: String?
    var showDetails: Bool = false
    var searchText: String = ""
    
    var filteredProducts: [Product] = []
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    let favoriteService: FavoriteServiceProtocol
    let productService: ProductServiceProtocol
    
    init(favoriteService: FavoriteServiceProtocol, productService: ProductServiceProtocol) {
        self.favoriteService = favoriteService
        self.productService = productService
    }
    
    func fetchProductsByCategory(category: ProductCategory) async {
        self.isLoading = true
        self.errorMessage = nil
        self.categoryProducts = []
        
        do {
            categoryProducts = try await productService.fetchProductsByCategory(category: category.slug)
            filteredProducts = categoryProducts
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func favoriteToggle(id: Int) {
        do {
            try favoriteService.favoriteToggle(id: id)
            try self.favoriteIds = favoriteService.getFavorites()
        } catch {
            errorMessage = "Error to favorite Product: \(error.localizedDescription)"
        }
    }
    
    func refreshFavorites() {
        do {
            try self.favoriteIds = favoriteService.getFavorites()
        }
        catch {
            errorMessage = "Error to refresh favorites Product: \(error.localizedDescription)"
        }
    }
    
    func selectedProductDetails(id: Int) {
        selectedProductId = id
    }
    
    func filterProducts(text: String) {
        if text.isEmpty {
            filteredProducts = categoryProducts
        } else {
            filteredProducts = categoryProducts.filter { product in
                product.title.localizedCaseInsensitiveContains(text)
            }
        }
    }
}
