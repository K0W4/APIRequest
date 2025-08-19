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
    
    func fetchTopPicks() async {
        isLoading = true

        do {
            topPicks = try await service.fetchProducts()
        } catch {
            errorMessage = "Error to fetch Products: \(error.localizedDescription)"
        }
    }
}
