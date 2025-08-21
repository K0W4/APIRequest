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
    var isLoading: Bool = false
    var errorMessage: String?
    var selectedProductId: Int? = nil
    var favoriteIds: [Int] = []
    
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
            
            for id in favoriteIds {
                let product = try await productService.fetchProduct(id: id)
                favorites.append(product)
            }
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
    
    func selectedProductDetails(id: Int) {
        selectedProductId = id
    }
}
