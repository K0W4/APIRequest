//
//  Purchase.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 15/08/25.
//

import Foundation
import SwiftUI

class Purchase: ObservableObject, Identifiable, Hashable {
    let id: UUID
    let product: Product
    var quantity: Int
    
    init(product: Product) {
        self.id = UUID()
        self.product = product
        self.quantity = 1
    }
    
    static func == (lhs: Purchase, rhs: Purchase) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
