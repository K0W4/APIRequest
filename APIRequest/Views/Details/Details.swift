//
//  Details.swift
//  APIRequest
//
//  Created by Gabriel Barbosa on 15/08/25.
//

import SwiftUI

struct Details: View {
    
    @Environment(\.dismiss) var dismiss
    @State var isFavorite: Bool
    
    var product: Product = Product(
        id: 5,
        title: "Dell XPS 13 Laptop",
        description: "Notebook premium com tela InfinityEdge, processador Intel Core i7 e 16GB de RAM.",
        category: .laptop,
        price: 1299.00
    )
    
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
                            
                        
                        FavoriteIcon(isFavorite: $isFavorite)
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
        Details(isFavorite: false)
    }
}
