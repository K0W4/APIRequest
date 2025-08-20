//
//  CategoryDisplayService.swift
//  APIRequest
//
//  Created by Gabriel Barbosa on 20/08/25.
//

import Foundation

class CategoryDisplayService: CategoryDisplayServiceProtocol {
    private let baseURL = "https://dummyjson.com"
    
    func fetchCategories() async throws -> [ProductCategory] {
        let urlString = "\(baseURL)/products/categories"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let categoryNames = try JSONDecoder().decode([ProductCategory].self, from: data)
        
        return categoryNames
    }
    
    
}
