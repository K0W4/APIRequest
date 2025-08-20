//
//  FavoriteService.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 20/08/25.
//

import Foundation

class FavoriteService: FavoriteServiceProtocol {
    static var favoriteIds: [Int] = []
    
    static func favoriteToggle(id: Int) {
        if let index = favoriteIds.firstIndex(where: {$0 == id}) {
            favoriteIds.remove(at: index)
        } else {
            favoriteIds.append(id)
        }
    }
}
