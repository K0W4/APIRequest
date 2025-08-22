//
//  HomeView.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI

struct HomeView: View {
    @State var viewModel: HomeViewModel = HomeViewModel(favoriteService: FavoriteService(), productService: ProductService())
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    if viewModel.isLoading {
                        ProgressView()
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                            .padding()
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
                                    selectedAction: { viewModel.selectedProductDetails(id: viewModel.deals?.id ?? 0)
                                        viewModel.showDetails = true
                                    },
                                    isFavorite: viewModel.favoriteIds.contains(viewModel.deals?.id ?? -1)) { viewModel.favoriteToggle(id: viewModel.deals?.id ?? 0) }
                            }
                        }
                            
                        VStack(spacing: 8) {
                            Text("Top picks")
                                .typography(.title2Emphasized)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                            LazyVGrid(columns: viewModel.columns) {
                                ForEach($viewModel.topPicks, id: \.id) { $product in
                                    ProductCard(product: $product, isHorizontal: false,
                                        selectedAction: { viewModel.selectedProductDetails(id: product.id)
                                            viewModel.showDetails = true
                                        },
                                        isFavorite: viewModel.favoriteIds.contains(product.id)) { viewModel.favoriteToggle(id: product.id) }
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
            .task {
                await viewModel.fetchProducts(id: 1)
                viewModel.refreshFavorites()
            }
        }
        .sheet(isPresented: $viewModel.showDetails, onDismiss: {
            viewModel.refreshFavorites()
            viewModel.selectedProductId = nil
        }) {
            if let id = viewModel.selectedProductId {
                DetailsView(id: id)
            }
        }
    }
}
