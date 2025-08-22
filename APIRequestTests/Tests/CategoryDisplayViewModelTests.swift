//
//  CategoryDisplayViewModelTests.swift
//  APIRequestTests
//
//  Created by Gabriel Kowaleski on 22/08/25.
//

@testable import APIRequest

import Testing

struct CategoryDisplayViewModelTests {
    @Test
    func fetchCategories_Success() async throws {
        // Given
        let categoryService = MockCategoryService()
        let viewModel = CategoryDisplayViewModel(service: categoryService)
        
        // When
        await viewModel.fetchCategories()
        
        // Then
        #expect(viewModel.categories.isEmpty == false)
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test
    func fetchCategories_Failure() async throws {
        // Given
        let categoryService = MockCategoryService(shouldFail: true)
        let viewModel = CategoryDisplayViewModel(service: categoryService)
        
        // When
        await viewModel.fetchCategories()
        
        // Then
        #expect(viewModel.categories.isEmpty)
        #expect(viewModel.errorMessage != nil)
    }
}
