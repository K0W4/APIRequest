//
//  CategoryDisplayViewModel.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 19/08/25.
//

import Foundation

@Observable
class CategoryDisplayViewModel {
    var categories: [ProductCategory] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let service: CategoryDisplayService

    init(service: CategoryDisplayService) {
        self.service = service
    }
    
    func fetchCategories() async {
        
        isLoading = true
        
        do {
            categories = try await service.fetchCategories()
        } catch {
            errorMessage = "Error to fetch Categories: \(error.localizedDescription)"
        }
        
        isLoading = false

    }
    
    
    
   
    
}
