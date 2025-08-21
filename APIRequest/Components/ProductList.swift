//
//  Default.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI

struct ProductList: View {
    var type: TypeProductList
    
    @Binding var product: Product?
    @Binding var purchase: Purchase?
    
    var selectedAction: (() -> Void)
    var cartAction: (() -> Void)?
    var date: Date = Date()
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: date)
    }
    
    var body: some View {
        switch type {
        case .cart:
            HStack(spacing: 8) {
                AsyncImage(url: URL(string: purchase!.product.thumbnail)) { image in
                    image.resizable()
                } placeholder: {
                    Image(.placeholder)
                        .resizable()
                }
                .frame(width: 94, height: 94)
                .cornerRadius(8)
                
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(purchase!.product.title)
                            .typography(.footnoteRegular)
                            .lineLimit(2)
                            .frame(height: 36, alignment: .top)
                                                
                        let formattedPrice = String(format: "%.2f", purchase!.product.price)
                        Text("US$ \(formattedPrice)")
                            .typography(.headline)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Button(action: { if purchase!.quantity  > 0 { purchase!.quantity -= 1 } }) {
                            Image(systemName: "minus")
                                .frame(width: 23, height: 23)
                                .typography(.caption1Regular)
                                .foregroundColor(.labelsPrimary)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(Color(.fillsQuaternary))
                                )
                        }
                        
                        Text("\(purchase!.quantity)")
                            .frame(width: 16)
                            .typography(.bodyRegular)
                            .foregroundColor(.labelsPrimary)
                        
                        Button(action: { if purchase!.quantity  < 9 { purchase!.quantity += 1 } }) {
                            Image(systemName: "plus")
                                .frame(width: 23, height: 23)
                                .typography(.caption1Regular)
                                .foregroundColor(.labelsPrimary)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(Color(.fillsTertiary))
                                )
                        }
                    }
                }
                .padding(8)
            }
            .frame(maxWidth: .infinity)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(Color(.backgroundsSecondary))
            )
            .onTapGesture {
                selectedAction()
            }
            
        case .favorite:
            HStack(spacing: 8) {
                AsyncImage(url: URL(string: product!.thumbnail)) { image in
                    image.resizable()
                } placeholder: {
                    Image(.placeholder)
                        .resizable()
                }
                .frame(width: 94, height: 94)
                .cornerRadius(8)
                
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(product!.title)
                            .typography(.footnoteRegular)
                            .lineLimit(2)
                                                
                        let formattedPrice = String(format: "%.2f", product!.price)
                        Text("US$ \(formattedPrice)")
                            .typography(.headline)
                    }
                    
                    Spacer()
                    
                    Button {
                        cartAction!()
                    } label: {
                        Image(systemName: "cart.fill")
                            .foregroundStyle(.labelsPrimary)
                            .typography(.bodyRegular)
                            .frame(width: 38, height: 38)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(Color(.fillsTertiary))
                            )
                    }
                }
                .padding(8)
            }
            .frame(maxWidth: .infinity)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(Color(.backgroundsSecondary))
            )
            .onTapGesture {
                selectedAction()
            }
            
        case .delivery:
            HStack(spacing: 8) {
                AsyncImage(url: URL(string: product!.thumbnail)) { image in
                    image.resizable()
                } placeholder: {
                    Image(.placeholder)
                        .resizable()
                }
                .frame(width: 94, height: 94)
                .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Delivery by \(formattedDate)")
                        .typography(.caption1Regular)
                        .foregroundStyle(.labelsSecondary)
                        .textCase(.uppercase)
                    
                    Text(product!.title)
                        .typography(.footnoteRegular)
                        .lineLimit(1)
                                                
                    let formattedPrice = String(format: "%.2f", product!.price)
                    Text("US$ \(formattedPrice)")
                        .typography(.headline)
                }
                .padding(8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(Color(.backgroundsSecondary))
            )
            .onTapGesture {
                selectedAction()
            }
        }
    }
}

enum TypeProductList {
    case cart, favorite, delivery
}
