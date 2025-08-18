//
//  ProductViewModelProtocol.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import Foundation

protocol ProductViewModelProtocol {
    var product: Product? { get }
    var productsByCategories: [Product] { get }
    var topPicks: [Product] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    func fetchProduct(id: Int) async
    func fetchProductsByCategory(category: String) async
    func fetchTopPicks() async
}
