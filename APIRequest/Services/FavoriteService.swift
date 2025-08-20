//
//  FavoriteService.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 20/08/25.
//

import Foundation

class FavoriteService: FavoriteServiceProtocol {
    func favoriteToggle(id: Int) {
        if let index = FavoriteProducts.ids.firstIndex(where: {$0 == id}) {
            FavoriteProducts.ids.remove(at: index)
        } else {
            FavoriteProducts.ids.append(id)
        }
    }
    
    func getFavorites() -> [Int] {
        return FavoriteProducts.ids
    }
}
