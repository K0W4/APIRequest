//
//  HomeView.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI

struct HomeView: View {
    @State var viewModel: HomeViewModel = HomeViewModel(service: ProductService())
    
    private let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                } else {
                    if let _ = viewModel.deals {
                        VStack(spacing: 8) {
                            Text("Deals of the day")
                                .typography(.title2Emphasized)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                            ProductCard (
                                product: Binding(
                                    get: { viewModel.deals! },
                                    set: { viewModel.deals = $0 }
                                ),
                                isHorizontal: true,
                                isFavorite: viewModel.favoriteIds.contains(viewModel.deals?.id ?? -1)) { viewModel.favoriteTogle(productId: viewModel.deals?.id ?? 0) }
                        }
                    }
                        
                    VStack(spacing: 8) {
                        Text("Top picks")
                            .typography(.title2Emphasized)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                        LazyVGrid(columns: columns) {
                            ForEach($viewModel.topPicks, id: \.id) { $product in
                                ProductCard(product: $product, isHorizontal: false,
                                            isFavorite: viewModel.favoriteIds.contains(product.id)) { viewModel.favoriteTogle(productId: product.id) }
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
            .refreshable {
                await viewModel.fetchProducts(id: 1)
            }
        }
        .task {
            await viewModel.fetchProducts(id: 1)
        }
    }
}

#Preview {
    TabBar()
}
