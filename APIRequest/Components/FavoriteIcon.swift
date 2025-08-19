//
//  FavoriteIcon.swift
//  APIRequest
//
//  Created by Gabriel Barbosa on 13/08/25.
//

import SwiftUI

struct FavoriteIcon: View {
    
    @Binding var product: Product
    
    var body: some View {
        
        Image(systemName: product.isFavorite ? "heart.fill" : "heart")
            .typography(.title3Regular)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.fillsTertiary)
                    .foregroundStyle(.graysGray5)
            )
            .onTapGesture {                
                product.isFavorite.toggle()
            }
    }
}

#Preview {
    var product: Product = Product(id: 1, title: "Product name with two or more lines goes here", description: "Descrição", category: "Category", price: 0.0, thumbnail: "Thumbnail")
    
    FavoriteIcon(product: .constant(product))
}
