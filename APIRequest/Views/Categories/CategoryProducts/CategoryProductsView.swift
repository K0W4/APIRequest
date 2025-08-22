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
    
    var category: ProductCategory
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 16) {
                    LazyVGrid(columns: viewModel.columns) {
                        ForEach($viewModel.filteredProducts, id: \.id) { $product in
                            ProductCard(product: $product,
                                        isHorizontal: false,
                                        selectedAction: { viewModel.selectedProductDetails(id: product.id)
                                viewModel.showDetails = true },
                                        isFavorite: viewModel.favoriteIds.contains(product.id)) { viewModel.favoriteToggle(id: product.id) }
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
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: viewModel.searchText) { _, newValue in
            viewModel.filterProducts(text: newValue)
        }
        .onDisappear {
            dismiss()
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
