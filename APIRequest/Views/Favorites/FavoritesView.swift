//
//  FavoritesView.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI

struct FavoritesView: View {
    @State private var searchText: String = ""
    @State private var isRecording: Bool = false
    
    var body: some View {
        VStack {
            FavoritesEmptyView()
        }
        .navigationTitle(Text("Favorites"))
        .background(.backgroundsPrimary)
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
        .searchable(text: $searchText)
        .onChange(of: searchText) { oldValue, newValue in
            // Faz o filtro (colocar interação por audio)
        }
    }
}

#Preview {
    TabBar()
}
