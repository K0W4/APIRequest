//
//  CategoryProductsViewModel.swift
//  APIRequest
//
//  Created by Gabriel Barbosa on 21/08/25.
//

import Foundation

@Observable
class CategoryProductsViewModel {
    
    var category: ProductCategory?
    var categoryProducts: [Product] = []
    var selectedProductId: Int? = nil
    var favoriteIds: [Int] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    var filteredProducts: [Product] = []
    
    let favoriteService: FavoriteServiceProtocol
    let productService: ProductServiceProtocol
    
    init(favoriteService: FavoriteServiceProtocol, productService: ProductServiceProtocol) {
        self.favoriteService = favoriteService
        self.productService = productService
    }
    
    func fetchProductsByCategory(category: ProductCategory) async {
        self.isLoading = true
        self.errorMessage = nil
        self.categoryProducts = []
        
        do {
            categoryProducts = try await productService.fetchProductsByCategory(category: category.slug)
            filteredProducts = categoryProducts
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func selectedProductDetails(id: Int) {
        selectedProductId = id
    }
    
    func favoriteTogle(id: Int) {
        do {
            try favoriteService.favoriteToggle(id: id)
            try self.favoriteIds = favoriteService.getFavorites()
        } catch {
            errorMessage = "Error to favorite Product: \(error.localizedDescription)"
        }
    }
    
    func refreshFavorites() {
        do {
            try self.favoriteIds = favoriteService.getFavorites()
        }
        catch {
            errorMessage = "Error to refresh favorites Product: \(error.localizedDescription)"
        }
    }
    
    func filterProducts(text: String) {
        
        if text.isEmpty {
            filteredProducts = categoryProducts
        } else {
            filteredProducts = categoryProducts.filter { product in
                product.title.localizedCaseInsensitiveContains(text)
            }
        }
    }
       
//   private func checkIfIsFavorite() {
//       guard let product = product else { return }
//       self.isFavorite = favoriteService.getFavorites().contains(product.id)
//   }

}
