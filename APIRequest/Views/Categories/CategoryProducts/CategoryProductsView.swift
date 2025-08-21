//
//  CategoryProductsView.swift
//  APIRequest
//
//  Created by Gabriel Barbosa on 21/08/25.
//

import SwiftUI

struct CategoryProductsView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var viewModel: CategoryProductsViewModel = CategoryProductsViewModel(favoriteService: FavoriteService(), productService: ProductService())
    @State var showDetails: Bool = false
    @State var searchText: String = ""
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var category: ProductCategory
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 16) {
                    LazyVGrid(columns: columns) {
                        ForEach($viewModel.filteredProducts, id: \.id) { $product in
                            ProductCard(product: $product,
                                        isHorizontal: false,
                                        selectedActoin: { viewModel.selectedProductDetails(id: product.id)
                                showDetails = true },
                                        isFavorite: viewModel.favoriteIds.contains(product.id)) { viewModel.favoriteTogle(id: product.id) }
                        }
                    }
                }
                .padding()
                .padding(.top, 8)
                .task {
                    await viewModel.fetchProductsByCategory(category: category)
                    viewModel.refreshFavorites()
                }
                .navigationTitle(category.name)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: searchText) { _, newValue in
            viewModel.filterProducts(text: newValue)
        }
        .onDisappear {
            dismiss()
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
