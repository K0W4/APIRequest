//
//  CartView.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI

struct CartView: View {

    @Environment(CartViewModel.self) private var cart
    
    @State private var isEmpty: Bool = false

    
    var body: some View {
        
        @Bindable var cart = cart
        
        NavigationStack{
            VStack {
                if isEmpty {
                    CartEmptyView()
                } else {
                    VStack(spacing: 16) {
                        ScrollView {
                            VStack(spacing: 16) {
                                
                                
                                ForEach($cart.products, id: \.product.id) { $purchase in
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
                                            cart.selectedProductId = $purchase.wrappedValue.product.id
                                            cart.showDetails = true
                                        },
                                        addAction: {
                                            cart.addProduct(product: $purchase.wrappedValue.product)
                                        },
                                        removeAction: {
                                            cart.removeProduct(product: $purchase.wrappedValue.product)
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
        .sheet(isPresented: $cart.showDetails, onDismiss: {
            cart.selectedProductId = nil
        }) {
            if let id = cart.selectedProductId {
                DetailsView(id: id)
            }
        }

    }
}
