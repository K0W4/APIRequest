//
//  FavoriteServiceProtocol.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 20/08/25.
//

import Foundation

protocol FavoriteServiceProtocol {    
    func favoriteToggle(id: Int) throws
    func getFavorites() throws -> [Int]
}
