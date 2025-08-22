//
//  DetailsViewModel.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 20/08/25.
//

import Foundation

@Observable
class DetailsViewModel {
    var isLoading: Bool = false
    var isFavorite: Bool = false
    var errorMessage: String?
    
    let favoriteService: FavoriteServiceProtocol
    
    init(favoriteService: FavoriteServiceProtocol) {
        self.favoriteService = favoriteService
    }
    
    func favoriteToggle(product: Product) {
        do {
            try favoriteService.favoriteToggle(id: product.id)
            checkIsFavorite(product: product)
        } catch {
            errorMessage = "Could not update favorite status: \(error.localizedDescription)"
        }
    }
       
    func checkIsFavorite(product: Product) {
        do {
            self.isFavorite = try favoriteService.getFavorites().contains(product.id)
        } catch {
            self.isFavorite = false
            errorMessage = "Could not check favorite status: \(error.localizedDescription)"
        }
    }
}
