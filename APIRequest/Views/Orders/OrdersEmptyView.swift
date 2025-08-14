//
//  OrdersEmptyView.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI

struct OrdersEmptyView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "bag.badge.questionmark")
                .font(.system(size: 48))
                .foregroundStyle(.graysGray2)
            
            VStack(spacing: 16) {
                Text("No orders yet!")
                    .typography(.bodyEmphasized)
                    .foregroundStyle(.labelsPrimary)
                
                Text("Buy an item and it will show up here.")
                    .typography(.bodyRegular)
                    .foregroundStyle(.labelsSecondary)
            }
        }
    }
}

#Preview {
    OrdersEmptyView()
}
