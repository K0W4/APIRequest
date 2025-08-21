//
//  MockFavoriteService.swift
//  APIRequestTests
//
//  Created by Gabriel Kowaleski on 20/08/25.
//

@testable import APIRequest

import Foundation

class MockFavoriteService: FavoriteServiceProtocol {
    var shouldFail: Bool
    var favoriteIds: [Int] = []
    
    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
    }
    
    func favoriteToggle(id: Int) throws {
        if shouldFail {
            throw NSError(domain: #function, code: 1)
        } else {
            if let index = favoriteIds.firstIndex(where: {$0 == id}) {
                favoriteIds.remove(at: index)
            } else {
                favoriteIds.append(id)
            }
        }
    }
    
    func getFavorites() throws -> [Int] {
        if shouldFail {
            throw NSError(domain: #function, code: 2)
        }
        return favoriteIds
    }
}
