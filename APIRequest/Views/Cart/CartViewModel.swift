//
//  CartViewModel.swift
//  APIRequest
//
//  Created by Gabriel Barbosa on 22/08/25.
//

import Foundation

@Observable
class CartViewModel {
    
    var products: [Purchase] = []
    var totalPrice: Double = 0
    var selectedProductId: Int?
    
    func addProduct(product: Product) {
        
        if let index = products.firstIndex(where: { $0.product == product }) {
            products[index].quantity += 1
        } else {
            let newPurchase = Purchase(product: product)
            products.append(newPurchase)
        }
        updateTotalPrice()
    }
    
    func removeProduct(product: Product) {
        guard let index = products.firstIndex(where: { $0.product == product }) else { return }
        
        if products[index].quantity > 1 {
            products[index].quantity -= 1
        } else {
            products.remove(at: index)
        }
        updateTotalPrice()
    }
    
    func updateTotalPrice() {
        totalPrice = products.reduce(0) { total, purchase in
            return total + purchase.subtotal
        }
    }
    
    func selectedProductDetails(id: Int) {
        selectedProductId = id
    }
}
