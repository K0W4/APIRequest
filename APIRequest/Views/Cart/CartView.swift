//
//  CartView.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI

struct CartView: View {
    var isEmpty: Bool = false
    var total: Double = 0
    
    @State var cart: [Purchase] = [
        Purchase(product: Product(
            id: 1,
            title: "Essence Mascara Lash Princess",
            description: "Mascara popular com efeito de volume e alongamento. Fórmula de longa duração e cruelty-free.",
            category: "beauty",
            price: 9.99,
            thumbnail: ""
        ))
    ]
    
    var body: some View {
        VStack {
            if isEmpty {
                CartEmptyView()
            } else {
                VStack(spacing: 16) {
                    ScrollView {
                        VStack(spacing: 16) {
//                            ForEach($cart, id: \.id) { $purchase in
//                                ProductList(
//                                    type: .cart,
//                                    productName: purchase.product.title,
//                                    productPrice: purchase.product.price,
//                                    quantity: $purchase.quantity
//                                )
//                            }
                        }
                    }
                    
                    VStack(spacing: 16) {
                        HStack {
                            Text("Total:")
                                .typography(.subheadlineRegular)
                                .foregroundStyle(.labelsPrimary)
                            
                            Spacer()
                            
                            Text("R$: \(total, specifier: "%.2f")")
                                .typography(.headline)
                                .foregroundStyle(.labelsPrimary)
                        }
                        
                        Button {
                            
                        } label: {
                            Text("Checkout")
                                .typography(.bodyEmphasized)
                                .foregroundStyle(.labelsPrimary)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .foregroundStyle(.fillsTertiary)
                                )
                        }
                    }
                    .padding(.bottom)
                }
            }
        }
        .padding(.horizontal)
        .navigationTitle(Text("Cart"))
        .background(.backgroundsPrimary)
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
    }
}

#Preview {
    CartView()
}
