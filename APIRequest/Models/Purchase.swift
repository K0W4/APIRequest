//
//  Purchase.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 15/08/25.
//

import Foundation

class Purchase {
    let id: UUID
    let product: Product
    let quantity: Int
    var purchase: [Product: Int] = [:]
    
    init(product: Product) {
        self.id = UUID()
        self.product = product
        self.quantity = 1
        self.purchase[product] = quantity
    }
}
