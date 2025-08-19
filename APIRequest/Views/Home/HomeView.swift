//
//  HomeView.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI

struct HomeView: View {
    var viewModel: HomeViewModel
    
    private let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        ScrollView{
            VStack(spacing: 16) {
                if let deals = viewModel.deals {
                    VStack(spacing: 8) {
                        Text("Deals of the day")
                            .typography(.title2Emphasized)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ProductCard(product: deals, isHorizontal: true)
                    }
                }
                
                VStack(spacing: 8) {
                    
                    Text("Top picks")
                        .typography(.title2Emphasized)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    LazyVGrid(columns: columns) {
                        if let topPicks = viewModel.topPicks{
                            ForEach(topPicks, id: \.id) { product in
                                ProductCard(product: product, isHorizontal: false)
                            }
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
