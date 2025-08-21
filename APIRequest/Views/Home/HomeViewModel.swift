//
//  HomeViewModel.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 18/08/25.
//

import Foundation

@Observable
class HomeViewModel {
    var deals: Product?
    var topPicks: [Product] = []
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
    
    func fetchProducts(id: Int) async {
        isLoading = true
        
        do {
            deals = try await productService.fetchProduct(id: id)
            topPicks = try await productService.fetchProducts()
        } catch {
            errorMessage = "Error to fetch Product: \(error.localizedDescription)"
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
}
