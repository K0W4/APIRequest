//
//  CategoryDisplayView.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI

struct CategoryDisplayView: View {
    @State var viewModel: CategoryDisplayViewModel = CategoryDisplayViewModel(service: CategoryDisplayService())
    @State private var searchText: String = ""
    @State private var isRecording: Bool = false
    
    var body: some View {
        VStack() {
                
            HStack(alignment: .top, spacing: 8){
                
                ForEach(viewModel.categories.prefix(4), id: \.id) { category in
                    
                    NavigationLink {
                        CategoryProductsView(category: category)
                    } label : {
                        CategoryIcon(category: category)
                    }
                       
                }
            }
            .padding()
            
            VStack() {
                List(viewModel.categories, id: \.id) { category in
                    NavigationLink {
                        CategoryProductsView(category: category)
                    } label: {
                        Text(category.name)
                    }
                    .frame(alignment: .leading)
                    .padding(8)
                
                }
                .listStyle(.plain)
            }
            
        }
        .navigationTitle(Text("Categories"))
        .background(.backgroundsPrimary)
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
        .searchable(text: $searchText)
        .onChange(of: searchText) { oldValue, newValue in
            // Faz o filtro (colocar interação por audio)
        }
        .task {
                await viewModel.fetchCategories()
            }
    }
}

#Preview {
    NavigationStack {
        CategoryDisplayView()
    }
}
