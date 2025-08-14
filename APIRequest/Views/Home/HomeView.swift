//
//  HomeView.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .navigationTitle(Text("Home"))
        .background(.backgroundsPrimary)
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
    }
}

#Preview {
    TabBar()
}
