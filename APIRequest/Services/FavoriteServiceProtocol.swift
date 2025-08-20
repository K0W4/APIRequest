//
//  FavoriteServiceProtocol.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 20/08/25.
//

import Foundation

protocol FavoriteServiceProtocol {
    var favoriteIds: [Int] { get }
    
    func favoriteToggle(id: Int)
}
