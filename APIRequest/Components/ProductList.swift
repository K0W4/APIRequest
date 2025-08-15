//
//  Default.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI

struct ProductList: View {
    var type: TypeProductList
    var productName: String = "Product name with two or more lines goes here"
    var productPrice: Double = 0.0
    @Binding var quantity: Int
    
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
                Image(.placeholder)
                    .resizable()
                    .frame(width: 78, height: 78)
                    .cornerRadius(8)
                
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(productName)
                            .typography(.footnoteRegular)
                            .lineLimit(2)
                            .frame(height: 36, alignment: .top)
                                                
                        let formattedPrice = String(format: "%.2f", productPrice)
                        Text("US$ \(formattedPrice)")
                            .typography(.headline)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Button(action: { if quantity  > 0 { quantity -= 1 } }) {
                            Image(systemName: "minus")
                                .frame(width: 23, height: 23)
                                .typography(.caption1Regular)
                                .foregroundColor(.labelsPrimary)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(Color(.fillsQuaternary))
                                )
                        }
                        
                        Text("\(quantity)")
                            .frame(width: 16)
                            .typography(.bodyRegular)
                            .foregroundColor(.labelsPrimary)
                        
                        Button(action: { if quantity  < 9 { quantity += 1 } }) {
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
            
        case .favorite:
            HStack(spacing: 8) {
                Image(.placeholder)
                    .resizable()
                    .frame(width: 78, height: 78)
                    .cornerRadius(8)
                
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(productName)
                            .typography(.footnoteRegular)
                            .lineLimit(2)
                                                
                        let formattedPrice = String(format: "%.2f", productPrice)
                        Text("US$ \(formattedPrice)")
                            .typography(.headline)
                    }
                    
                    Spacer()
                    
                    Button {
                        
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
            
        case .delivery:
            HStack(spacing: 8) {
                Image(.placeholder)
                    .resizable()
                    .frame(width: 78, height: 78)
                    .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Delivery by \(formattedDate)")
                        .typography(.caption1Regular)
                        .foregroundStyle(.labelsSecondary)
                        .textCase(.uppercase)
                    
                    Text(productName)
                        .typography(.footnoteRegular)
                        .lineLimit(1)
                                                
                    let formattedPrice = String(format: "%.2f", productPrice)
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
        }
    }
}

enum TypeProductList {
    case cart, favorite, delivery
}

#Preview {
    var count: Int = 1
    ProductList(type: .cart, quantity: .constant(count))
}
