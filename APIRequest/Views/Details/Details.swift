//
//  Details.swift
//  APIRequest
//
//  Created by Gabriel Barbosa on 15/08/25.
//

import SwiftUI

struct Details: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var product: Product
    
    var body: some View {
        ScrollView{
            VStack(spacing: 16) {
                ZStack(alignment: .topTrailing){
                    Image("Placeholder")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(32)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundStyle(Color(.backgroundsSecondary))
                                .padding()
                        )
                    
                    // TODO: Ajustar isFavorite
//                    FavoriteIcon(product: $product) {
//                        product.isFavorite.toggle()
//                    }
                        .padding()
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text(product.title)
                        .typography(.title3Regular)
                        .padding(.top,8)
                    
                    let formattedPrice = String(format: "%.2f", product.price)
                    Text("US$ \(formattedPrice)")
                        .typography(.title2Emphasized)
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                
                Text(product.description)
                    .typography(.bodyRegular)
                    .foregroundStyle(.labelsSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        Text("Add to Cart")
            .typography(.bodyEmphasized)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.fillsTertiary))
            )
            .onTapGesture {
                dismiss()
            }
            .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        let product: Product = Product(id: 1, title: "Product name with two or more lines goes here", description: "Descrição", category: "Category", price: 0.0, thumbnail: "Thumbnail")
        
        Details(product: .constant(product))
    }
}
