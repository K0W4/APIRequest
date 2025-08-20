//
//  FavoriteIcon.swift
//  APIRequest
//
//  Created by Gabriel Barbosa on 13/08/25.
//

import SwiftUI

struct FavoriteIcon: View {
    var isFavorite: Bool
    var action: (() -> Void)
    
    var body: some View {
        Image(systemName: isFavorite ? "heart.fill" : "heart")
            .typography(.title3Regular)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.fillsTertiary)
                    .foregroundStyle(.graysGray5)
            )
            .onTapGesture {                
                action()
            }
    }
}

#Preview {
    FavoriteIcon(isFavorite: true, action: { })
}
