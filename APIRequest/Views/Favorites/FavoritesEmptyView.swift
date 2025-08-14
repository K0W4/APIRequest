//
//  FavoritesEmptyView.swift
//  APIRequest
//
//  Created by Gabriel Kowaleski on 13/08/25.
//

import SwiftUI

struct FavoritesEmptyView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "heart.slash")
                .font(.system(size: 48))
                .foregroundStyle(.graysGray2)
            
            VStack(spacing: 16) {
                Text("No favorites yet!")
                    .typography(.bodyEmphasized)
                    .foregroundStyle(.labelsPrimary)
                
                Text("Favorite an item and it will show up here.")
                    .typography(.bodyRegular)
                    .foregroundStyle(.labelsSecondary)
            }
        }
    }
}

#Preview {
    FavoritesEmptyView()
}
