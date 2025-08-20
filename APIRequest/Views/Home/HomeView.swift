//
//  HomeView.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI

struct HomeView: View {
    @State var viewModel: HomeViewModel = HomeViewModel(favoriteService: FavoriteService(), productService: ProductService())
    @State var showDetails: Bool = false
    
    private let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
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
                                    selectedActoin: { viewModel.selectedProductDetails(id: viewModel.deals?.id ?? 0)
                                    showDetails = true
                                    },
                                    isFavorite: viewModel.favoriteIds.contains(viewModel.deals?.id ?? -1)) { viewModel.favoriteTogle(id: viewModel.deals?.id ?? 0) }
                            }
                        }
                            
                        VStack(spacing: 8) {
                            Text("Top picks")
                                .typography(.title2Emphasized)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                            LazyVGrid(columns: columns) {
                                ForEach($viewModel.topPicks, id: \.id) { $product in
                                    ProductCard(product: $product, isHorizontal: false,
                                        selectedActoin: { viewModel.selectedProductDetails(id: product.id)
                                        showDetails = true
                                        },
                                        isFavorite: viewModel.favoriteIds.contains(product.id)) { viewModel.favoriteTogle(id: product.id) }
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
            }
        }
        .sheet(isPresented: $showDetails, onDismiss: {
            viewModel.refreshFavorites()
            viewModel.selectedProductId = nil
        }) {
            if let id = viewModel.selectedProductId {
                DetailsView(id: id)
            }
        }
    }
}
