//
//  CartView.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI

struct CartView: View {

    @Environment(CartViewModel.self) private var cart
    
    @State private var showDetails = false
    @State private var selectedProductId: Int? = nil
    @State private var isEmpty: Bool = false

    
    var body: some View {
        
        @Bindable var cart = cart
        
        VStack {
            if isEmpty {
                CartEmptyView()
            } else {
                VStack(spacing: 16) {
                    ScrollView {
                        VStack(spacing: 16) {
                            
                            
                            ForEach($cart.products) { $purchase in
                                ProductList(
                                    type: .cart,
                                    product: .constant(nil),
                                    purchase: Binding<Purchase?>(
                                        get: { $purchase.wrappedValue },
                                        set: {
                                            if let newValue = $0 {
                                                $purchase.wrappedValue = newValue
                                            }
                                        }
                                    ),
                                    selectedAction: {
                                        selectedProductId = $purchase.wrappedValue.product.id
                                        showDetails = true
                                    }
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
                            
                            Text("R$: \(cart.totalPrice, specifier: "%.2f")")
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
