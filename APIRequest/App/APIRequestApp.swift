//
//  APIRequestApp.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI
import SwiftData

@main
struct APIRequestApp: App {
    
    @State private var cart = CartViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabBar()
                .environment(cart)
        }
    }
}
