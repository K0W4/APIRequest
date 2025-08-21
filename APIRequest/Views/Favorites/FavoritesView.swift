//
//  FavoritesView.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI

struct FavoritesView: View {
    @State var viewModel: FavoritesViewModel = FavoritesViewModel(favoriteService: FavoriteService(), productService: ProductService())
    @State var searchText: String = ""
    @State var showDetails: Bool = false
    
    var isEmpty: Bool = false
    
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
                    } else if viewModel.favorites.isEmpty {
                        FavoritesEmptyView()
                    } else {
                        ForEach($viewModel.favorites, id: \.id) { $product in
                            ProductList(
                                type: .favorite,
                                product: Binding<Product?>(
                                    get: { $product.wrappedValue },
                                    set: {
                                        if let newValue = $0 {
                                            $product.wrappedValue = newValue
                                        }
                                    }
                                ),
                                purchase: .constant(nil),
                                selectedAction: { viewModel.selectedProductId = product.id
                                    showDetails = true
                                },
                            )
                        }
                    }
                }
                .padding(.horizontal)
                .navigationTitle(Text("Favorites"))
                .background(.backgroundsPrimary)
                .toolbarBackgroundVisibility(.visible, for: .tabBar)
                .searchable(text: $searchText)
            }
            .task {
                await viewModel.fetchFavoriteProducts()
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
