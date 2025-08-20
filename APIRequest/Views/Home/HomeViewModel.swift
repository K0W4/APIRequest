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
        self.favoriteIds = favoriteService.favoriteIds
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
    
    func selectedProductDetails(id: Int) {
        selectedProductId = id
    }
    
    func favoriteTogle(id: Int) {
        favoriteService.favoriteToggle(id: id)
        self.favoriteIds = favoriteService.favoriteIds
    }
}
