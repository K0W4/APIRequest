//
//  TabBar.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill")
            {
                NavigationStack {
                    HomeView()
                }
            }
            
            Tab("Categories", systemImage: "square.grid.2x2.fill")
            {
                NavigationStack {
                    CategoryDisplayView()
                }
            }
            
            Tab("Cart", systemImage: "cart.fill")
            {
                NavigationStack {
                    CartView()
                }
            }
            
            Tab("Favorites", systemImage: "heart.fill")
            {
                NavigationStack {
                    FavoritesView()
                }
            }
            
            Tab("Orders", systemImage: "bag.fill")
            {
                NavigationStack {
                    OrdersView()
                }
            }
        }
    }
}

#Preview {
    TabBar()
}
