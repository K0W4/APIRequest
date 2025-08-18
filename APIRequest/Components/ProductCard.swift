//
//  ProductCard.swift
//  APIRequest
//
//  Created by Gabriel Barbosa on 13/08/25.
//

import SwiftUI

struct ProductCard: View {
    @Binding var product: Product
    
    var isHorizontal: Bool
    
    var body: some View {
        
        if isHorizontal {
            HStack(alignment: .top, spacing: 16) {
                
                Image("Placeholder")
                    .resizable()
                    .frame(width: 160, height: 160)
                    .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 24) {
                    
                    HStack(spacing: 4) {
                        Text("\(product.category)".uppercased())
                            .typography(.footnoteRegular)
                            .foregroundStyle(Color(.labelsSecondary))
                        
                        Spacer()
   
                        FavoriteIcon(isFavorite: $product.isFavorite)
                    }
                    
                    VStack (alignment: .leading, spacing: 4) {
                        Text("\(product.title)")
                            .typography(.subheadlineRegular)
                            .lineLimit(2)
                                                
                        let formattedPrice = String(format: "%.2f", product.price)
                        Text("US$ \(formattedPrice)")
                            .typography(.headline)
                    }
                }
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(Color(.backgroundsSecondary))
            )
        }
        
        else {
            
            VStack(alignment: .leading, spacing: 8) {
                
                ZStack(alignment: .topTrailing) {
                    
                    Image("Placeholder")
                        .resizable()
                        .frame(width: 160, height: 160)
                        .cornerRadius(8)
                    
                    FavoriteIcon(isFavorite: $product.isFavorite)
                    
                }
                
                VStack(alignment: .leading) {
                    Text("\(product.title)")
                        .typography(.subheadlineRegular)
                        .lineLimit(2)
                        .frame(height: 36, alignment: .top)
                        .padding(.bottom, 4)
                                      
                    let formattedPrice = String(format: "%.2f", product.price)
                    Text("US$ \(formattedPrice)")
                        .typography(.headline)
                    
                    
                }
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(Color(.backgroundsSecondary))
            )
            .frame(width: 177)
          
        }
    }
}

#Preview {
    var product: Product = Product(id: 1, title: "Product name with two or more lines goes here", description: "Descrição", category: "Category", price: 0.0, thumbnail: "Thumbnail")
    
    ProductCard(product: .constant(product), isHorizontal: false)
}
