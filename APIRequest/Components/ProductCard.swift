//
//  ProductCard.swift
//  APIRequest
//
//  Created by Gabriel Barbosa on 13/08/25.
//

import SwiftUI

struct ProductCard: View {
    
    var category: String = "Category"
    var productName: String = "Product name with two or Pore lines goes here"
    var productPrice: Double = 0.0
    var isHorizontal: Bool = false
    
    @State var isFavorite: Bool = false
    
    var body: some View {
        
        if isHorizontal {
            HStack(alignment: .top, spacing: 16) {
                
                Image("Placeholder")
                    .resizable()
                    .frame(width: 160, height: 160)
                    .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 24) {
                    
                    HStack(spacing: 4) {
                        Text("\(category)".uppercased())
                            .typography(.footnoteRegular)
                            .foregroundStyle(Color(.labelsSecondary))
                        
                        Spacer()
   
                        FavoriteIcon(isFavorite: $isFavorite)
                    }
                    
                    VStack (alignment: .leading, spacing: 4) {
                        Text("\(productName)")
                            .typography(.subheadlineRegular)
                            .lineLimit(2)
                                                
                        let formattedPrice = String(format: "%.2f", productPrice)
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
                    
                    FavoriteIcon(isFavorite: $isFavorite)
                    
                }
                
                VStack(alignment: .leading) {
                    Text("\(productName)")
                        .typography(.subheadlineRegular)
                        .lineLimit(2)
                        .frame(height: 36, alignment: .top)
                        .padding(.bottom, 4)
                                      
                    let formattedPrice = String(format: "%.2f", productPrice)
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
    ProductCard()
}
