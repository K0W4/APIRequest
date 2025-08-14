//
//  CartView.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI

struct CartView: View {
    var body: some View {
        VStack {
            CartEmptyView()
        }
        .navigationTitle(Text("Cart"))
        .background(.backgroundsPrimary)
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
    }
}

#Preview {
    TabBar()
}
