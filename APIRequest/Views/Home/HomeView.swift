//
//  HomeView.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI

struct HomeView: View {
    
    private let columns = [
            GridItem(.flexible(), spacing: 0),
            GridItem(.flexible(), spacing: 0)
        ]
    
    let topPicks: [Product] = [
        Product(
            id: 1,
            title: "Essence Mascara Lash Princess",
            description: "Mascara popular com efeito de volume e alongamento. Fórmula de longa duração e cruelty-free.",
            category: .beauty,
            price: 9.99
        ),
        Product(
            id: 2,
            title: "iPhone 14 Pro",
            description: "Smartphone Apple com tela Super Retina XDR, chip A16 Bionic e sistema de câmeras Pro.",
            category: .smartphones,
            price: 999.00
        ),
        Product(
            id: 3,
            title: "Nike Air Zoom Pegasus 39",
            description: "Tênis de corrida leve e confortável, ideal para treinos e corridas de longa distância.",
            category: .mensShoes,
            price: 120.00
        ),
        Product(
            id: 4,
            title: "Samsung 55'' 4K Smart TV",
            description: "Smart TV com resolução 4K UHD, HDR e sistema Tizen para acesso a diversos aplicativos.",
            category: .homeDecoration,
            price: 599.99
        ),
        Product(
            id: 5,
            title: "Dell XPS 13 Laptop",
            description: "Notebook premium com tela InfinityEdge, processador Intel Core i7 e 16GB de RAM.",
            category: .laptop,
            price: 1299.00
        )
    ]
    
    var body: some View {
        
        ScrollView{
            VStack(spacing: 16) {
                
                
                VStack(spacing: 8) {
                    
                    Text("Deals of the day")
                        .typography(.title2Emphasized)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ProductCard(isHorizontal: true)
                    
                }
                
                VStack(spacing: 8) {
                    
                    Text("Top picks")
                        .typography(.title2Emphasized)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    LazyVGrid(columns: columns) {
                        ForEach(topPicks, id: \.id) { product in
                            ProductCard(productName: product.title, productPrice: product.price)
                        }
                    }
                    
                }

                Spacer()
                
            }
            .padding()
            .navigationTitle(Text("Home"))
            .background(.backgroundsPrimary)
            .toolbarBackgroundVisibility(.visible, for: .tabBar)
        }
    }
}

#Preview {
    TabBar()
}
