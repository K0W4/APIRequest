//
//  CategoryServiceProtocol.swift
//  APIRequest
//
//  Created by Gabriel Barbosa on 20/08/25.
//

import Foundation

protocol CategoryServiceProtocol {
    
    func fetchCategories() async throws -> [ProductCategory]
}

