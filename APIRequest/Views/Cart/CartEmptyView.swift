//
//  CartEmptyView.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI

struct CartEmptyView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "cart.badge.questionmark")
                .font(.system(size: 48))
                .foregroundStyle(.graysGray2)
            
            VStack(spacing: 16) {
                Text("Your cart is empty!")
                    .typography(.bodyEmphasized)
                    .foregroundStyle(.labelsPrimary)
                
                Text("Add an item to your cart.")
                    .typography(.bodyRegular)
                    .foregroundStyle(.labelsSecondary)
            }
        }
    }
}

#Preview {
    CartEmptyView()
}
