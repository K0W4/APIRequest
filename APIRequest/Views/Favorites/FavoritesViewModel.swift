//
//  FavoritesViewModel.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 21/08/25.
//

import Foundation

@Observable
class FavoritesViewModel {
    var favorites: [Product] = []
    var filteredProducts: [Product] = []
    var isLoading: Bool = false
    var errorMessage: String?
    var selectedProduct: Product? = nil
    var favoriteIds: [Int] = []
    var searchText: String = ""
    var showDetails: Bool = false
    
    let favoriteService: FavoriteServiceProtocol
    let productService: ProductServiceProtocol
    
    init(favoriteService: FavoriteServiceProtocol, productService: ProductServiceProtocol) {
        self.favoriteService = favoriteService
        self.productService = productService
    }
    
    func fetchFavoriteProducts() async {
        isLoading = true
    
        do {
            favoriteIds = try favoriteService.getFavorites()
            self.filteredProducts = self.favorites
            
            var fetchedProducts: [Product] = []
            
            try await withThrowingTaskGroup(of: Product.self) { group in
                for id in favoriteIds {
                    group.addTask {
                        return try await self.productService.fetchProduct(id: id)
                    }
                }
                for try await product in group {
                    fetchedProducts.append(product)
                }
            }
            
            self.favorites = fetchedProducts.sorted { $0.id < $1.id }
            self.filteredProducts = self.favorites
        } catch {
            errorMessage = "Failed to load favorites: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func refreshFavorites() {
        do {
            try self.favoriteIds = favoriteService.getFavorites()
        }
        catch {
            errorMessage = "Error to refresh favorites Product: \(error.localizedDescription)"
        }
    }
    
    func selectedProductDetails(product: Product) {
        selectedProduct = product
    }
    
    func filterProducts(text: String) {
        if text.isEmpty {
            filteredProducts = favorites
        } else {
            filteredProducts = favorites.filter { product in
                product.title.localizedCaseInsensitiveContains(text)
            }
        }
    }
}
