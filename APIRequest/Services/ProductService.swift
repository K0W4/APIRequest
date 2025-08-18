//
//  ProductService.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 18/08/25.
//

import Foundation

class ProductService: ProductServiceProtocol {
    
    private let baseURL = "https://dummyjson.com"
    
    
    func fetchProduct(id: Int) async throws -> Product {
        let urlString = "\(baseURL)/products/\(id)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let productResponse = try JSONDecoder().decode(Product.self, from: data)
        
        return productResponse
    }
    
    func fetchProducts() async throws -> [Product] {
        let urlString = "\(baseURL)/products"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let productResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
        
        return productResponse.results
    }
    
    func fechProductByCategory(category: String) async throws -> [Product] {
        let urlString = "\(baseURL)/products/category/\(category)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let productCategoryResponse = try JSONDecoder().decode(ProductCategoryResponse.self, from: data)
        
        return productCategoryResponse.results
    }
}
