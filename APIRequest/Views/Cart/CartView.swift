//
//  CartView.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI

struct CartView: View {
    var isEmpty: Bool = false
    var total: Double {
        cart.reduce(0) { result, purchase in
            result + (purchase.product.price * Double(purchase.quantity))
        }
    }
    
    @State var cart: [Purchase] = [
        Purchase(product: Product(
            id: 1,
            title: "Essence Mascara Lash Princess",
            description: "Mascara popular com efeito de volume e alongamento. Fórmula de longa duração e cruelty-free.",
            category: .beauty,
            price: 9.99
        )),
        Purchase(product: Product(
            id: 2,
            title: "iPhone 14 Pro",
            description: "Smartphone Apple com tela Super Retina XDR, chip A16 Bionic e sistema de câmeras Pro.",
            category: .smartphones,
            price: 999.00
        )),
        Purchase(product: Product(
            id: 3,
            title: "Nike Air Zoom Pegasus 39",
            description: "Tênis de corrida leve e confortável, ideal para treinos e corridas de longa distância.",
            category: .mensShoes,
            price: 120.00
        )),
        Purchase(product: Product(
            id: 4,
            title: "Samsung 55'' 4K Smart TV",
            description: "Smart TV com resolução 4K UHD, HDR e sistema Tizen para acesso a diversos aplicativos.",
            category: .homeDecoration,
            price: 599.99
        )),
        Purchase(product: Product(
            id: 5,
            title: "Dell XPS 13 Laptop",
            description: "Notebook premium com tela InfinityEdge, processador Intel Core i7 e 16GB de RAM.",
            category: .laptop,
            price: 1299.00
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
                            ForEach($cart, id: \.id) { $purchase in
                                ProductList(
                                    type: .cart,
                                    productName: purchase.product.title,
                                    productPrice: purchase.product.price,
                                    count: purchase.quantity
                                )
                            }
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
