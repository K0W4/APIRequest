//
//  Product.swift
//  APIRequest
//
//  Created by Gabriel Barbosa on 14/08/25.
//

import Foundation

class Product: Decodable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let category: ProductCategory
    let price: Double
    
    init(id: Int, title: String, description: String, category: ProductCategory, price: Double) {
        self.id = id
        self.title = title
        self.description = description
        self.category = category
        self.price = price
    }
}
