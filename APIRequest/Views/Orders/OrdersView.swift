//
//  OrdersView.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI

struct OrdersView: View {
    @State private var searchText: String = ""
    @State private var isRecording: Bool = false
    
    var isEmpty: Bool = false
    
    @State var orders: [Purchase] = [
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
            VStack {
                if isEmpty {
                    OrdersEmptyView()
                } else {
                    VStack(spacing: 16) {
                        ScrollView {
                            VStack(spacing: 16) {
//                                ForEach($orders, id: \.id) { $purchase in
//                                    ProductList(
//                                        type: .delivery,
//                                        productName: purchase.product.title,
//                                        productPrice: purchase.product.price,
//                                        quantity: $purchase.quantity
//                                    )
//                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
        .navigationTitle(Text("Orders"))
        .background(.backgroundsPrimary)
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
        .searchable(text: $searchText)
        .onChange(of: searchText) { oldValue, newValue in
            // Faz o filtro (colocar interação por audio)
        }
    }
}

#Preview {
    OrdersView()
}
