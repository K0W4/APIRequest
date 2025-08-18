//
//  Product.swift
//  APIRequest
//
//  Created by Gabriel Barbosa on 14/08/25.
//

import Foundation

class ProductResponse: Decodable {
    var results: [Product]
}

class ProductCategoryResponse: Decodable {
    var results: [Product]
}

class Product: Decodable {
    var id: Int
    var title: String
    var description: String
    var category: String
    var price: Double
    var thumbnail: String
    var isFavorite: Bool = false
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case description
        case category
        case price
        case thumbnail
    }
    
    init(id: Int, title: String, description: String, category: String, price: Double, thumbnail: String) {
        self.id = id
        self.title = title
        self.description = description
        self.category = category
        self.price = price
        self.thumbnail = thumbnail
    }
}
