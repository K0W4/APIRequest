//
//  CategoryIcon.swift
//  APIRequest
//
//  Created by Gabriel Barbosa on 15/08/25.
//

import SwiftUI

struct CategoryIcon: View {
    var category: ProductCategory

    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.backgroundsSecondary))
                .frame(width: 84, height: 84)
                .overlay(
                    Image(systemName: category.imageName)
                        .font(.system(size: 38, weight: .regular))
                        .foregroundStyle(.fillsSecondary)
                )

            Text(category.rawValue)
                .typography(.subheadlineRegular)
                .foregroundColor(.labelsPrimary)
                .multilineTextAlignment(.center)
                .lineLimit(2)                // até 2 linhas
                .fixedSize(horizontal: false, vertical: true) // força expandir pra baixo
        }
        .frame(width: 84) // fixa largura, altura ajusta automaticamente
    }
}

#Preview {
    CategoryIcon(category: .beauty)
}
