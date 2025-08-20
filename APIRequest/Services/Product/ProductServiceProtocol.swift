//
//  ProductServiceProtocol.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import Foundation

protocol ProductServiceProtocol {
    func fetchProduct(id: Int) async throws -> Product
    func fetchProducts() async throws -> [Product]
    func fechProductsByCategory(category: String) async throws -> [Product]
}
