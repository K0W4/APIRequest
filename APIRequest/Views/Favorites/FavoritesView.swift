//
//  FavoritesView.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI

struct FavoritesView: View {
    @State var viewModel: FavoritesViewModel = FavoritesViewModel(favoriteService: FavoriteService(), productService: ProductService())
        
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.filteredProducts.isEmpty && !viewModel.isLoading {
                    if viewModel.searchText.isEmpty {
                        FavoritesEmptyView()
                    } else {
                        ContentUnavailableView.search(text: viewModel.searchText)
                    }
                } else if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .padding()
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach($viewModel.filteredProducts, id: \.id) { $product in
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
                                    selectedAction: {
                                        viewModel.selectedProductId = product.id
                                        viewModel.showDetails = true
                                    },
                                    cartAction: {}
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle(Text("Favorites"))
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
            .background(.backgroundsPrimary)
            .toolbarBackgroundVisibility(.visible, for: .tabBar)
            .onChange(of: viewModel.searchText) { oldValue, newValue in
                viewModel.filterProducts(text: newValue)
            }
            .task {
                viewModel.refreshFavorites()
                await viewModel.fetchFavoriteProducts()
            }
            .sheet(isPresented: $viewModel.showDetails, onDismiss: {
                Task {
                    viewModel.refreshFavorites()
                    await viewModel.fetchFavoriteProducts()
                }
                viewModel.selectedProductId = nil
            }) {
                if let id = viewModel.selectedProductId {
                    DetailsView(id: id)
                }
            }
        }
    }
}
