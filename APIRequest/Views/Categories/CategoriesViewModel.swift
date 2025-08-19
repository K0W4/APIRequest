//
//  CategoriesViewModel.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 19/08/25.
//

import Foundation

@Observable
class CategoriesViewModel {
    var deals: Product?
    var productsByCategories: [Product] = []
    var topPicks: [Product] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let service: ProductServiceProtocol

    init(service: ProductServiceProtocol) {
        self.service = service
    }
    
    func fetchProduct(id: Int) async {
        isLoading = true
        
        do {
            deals = try await service.fetchProduct(id: id)
        } catch {
            errorMessage = "Error to fetch Product: \(error.localizedDescription)"
        }
    }
    
    func fetchProductsByCategory(category: String) async {
        isLoading = true

        do {
            productsByCategories = try await service.fechProductsByCategory(category: category)
        } catch {
            errorMessage = "Error to fetch Product by Category: \(error.localizedDescription)"
        }
    }
    
    func fetchTopPicks() async {
        isLoading = true

        do {
            topPicks = try await service.fetchProducts()
        } catch {
            errorMessage = "Error to fetch Products: \(error.localizedDescription)"
        }
    }
}
