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
                    Image(systemName: category.symbolName)
                        .font(.system(size: 38, weight: .regular))
                        .foregroundStyle(.fillsSecondary)
                )

            Text(category.name)
                .typography(.subheadlineRegular)
                .foregroundColor(.labelsPrimary)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(width: 84)
    }
}

#Preview {
    let sampleCategory = ProductCategory(name: "Furniture") 
    CategoryIcon(category: sampleCategory)
}
