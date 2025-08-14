//
//  Product.swift
//  APIRequest
//
//  Created by Gabriel Barbosa on 14/08/25.
//

import Foundation

struct Product: Decodable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let category: ProductCategory
    let price: Double
}
