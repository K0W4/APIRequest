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
    var id: Int
    
    let favoriteService: FavoriteServiceProtocol
    let productService: ProductServiceProtocol
    
    init(favoriteService: FavoriteServiceProtocol, productService: ProductServiceProtocol, id: Int) {
        self.favoriteService = favoriteService
        self.productService = productService
        self.id = id
    }
    
    func fetchProduct(id: Int) async {
        isLoading = true
        
        do {
            product = try await productService.fetchProduct(id: id)
            checkIsFavorite()
        } catch {
            errorMessage = "Error to fetch Product: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func favoriteToggle() {
        guard let product = product else { return }
        
        do {
            try favoriteService.favoriteToggle(id: product.id)
                checkIsFavorite()
        } catch {
            errorMessage = "Could not update favorite status: \(error.localizedDescription)"
        }
    }
       
    func checkIsFavorite() {
        guard let product = product else { return }
        
        do {
            self.isFavorite = try favoriteService.getFavorites().contains(product.id)
        } catch {
            self.isFavorite = false
            errorMessage = "Could not check favorite status: \(error.localizedDescription)"
        }
    }
}
