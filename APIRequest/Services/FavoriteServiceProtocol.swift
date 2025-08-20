//
//  FavoriteServiceProtocol.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 20/08/25.
//

import Foundation

protocol FavoriteServiceProtocol {
    static var favoriteIds: [Int] { get }
    
    static func favoriteToggle(id: Int)
}
