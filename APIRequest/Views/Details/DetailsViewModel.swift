//
//  DetailsViewModel.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 20/08/25.
//

import Foundation

@Observable
class DetailsViewModel {
    var product: Product?
    var isLoading: Bool = false
    var isFavorite: Bool = false
    var errorMessage: String?
    
    let productService: ProductServiceProtocol
    
    init(productService: ProductServiceProtocol = ProductService()) {
        self.productService = productService
    }
    
    func fetchProduct(id: Int) async {
        isLoading = true
        
        do {
            product = try await productService.fetchProduct(id: id)
            checkIfIsFavorite()
        } catch {
            errorMessage = "Error to fetch Product: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func favoriteToggle() {
           guard let product = product else { return }
           FavoriteService.favoriteToggle(id: product.id)
           checkIfIsFavorite()
       }
       
       private func checkIfIsFavorite() {
           guard let product = product else { return }
           self.isFavorite = FavoriteService.favoriteIds.contains(product.id)
       }
}
