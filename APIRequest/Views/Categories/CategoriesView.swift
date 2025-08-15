//
//  CategoriesView.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI

struct CategoriesView: View {
    @State private var searchText: String = ""
    @State private var isRecording: Bool = false
    
    var body: some View {
        VStack() {
            
            HStack(spacing: 8){
                CategoryIcon(category: .beauty)
                CategoryIcon(category: .beauty)
                CategoryIcon(category: .beauty)
                CategoryIcon(category: .beauty)
            }
            .padding()
            
            VStack() {
                List(ProductCategory.allCases, id: \.self) { category in
                    NavigationLink(value: category) {
                        Text(category.rawValue)
                            .padding(.top, 8)
                    }
                    //.frame(height: 60,alignment: .leading)
        
                    
                }
                .listStyle(.plain)
//                        .navigationDestination(for: ProductCategory.self) { category in
//                            CategoryDetailView(category: category)   // tela de destino
//                        }
            }
            
        }
        .navigationTitle(Text("Categories"))
        .background(.backgroundsPrimary)
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
        .searchable(text: $searchText)
        .onChange(of: searchText) { oldValue, newValue in
            // Faz o filtro (colocar interação por audio)
        }
    }
}

#Preview {
    NavigationStack {
        CategoriesView()
    }
}
