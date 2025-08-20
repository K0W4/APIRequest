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
    var favoriteIds: [Int] = []
    
    private let service: ProductServiceProtocol

    init(service: ProductServiceProtocol) {
        self.service = service
    }
    
    func fetchProducts(id: Int) async {
        isLoading = true
        
        do {
            deals = try await service.fetchProduct(id: id)
            topPicks = try await service.fetchProducts()
        } catch {
            errorMessage = "Error to fetch Product: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func favoriteTogle(productId: Int) {
        if let index = favoriteIds.firstIndex(where: {$0 == productId}) {
            favoriteIds.remove(at: index)
        } else {
            favoriteIds.append(productId)
        }
//        service.favoriteTogle
        // favoriteIds = service.getFavirites()
        
    }
    
}
