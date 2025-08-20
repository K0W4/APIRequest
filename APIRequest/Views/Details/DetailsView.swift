//
//  DetailsView.swift
//  APIRequest
//
//  Created by Gabriel Barbosa on 15/08/25.
//

import SwiftUI

struct DetailsView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var viewModel: DetailsViewModel = DetailsViewModel(favoriteService: FavoriteService(), productService: ProductService())
    
    var id: Int
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .padding()
                } else if let product = viewModel.product {
                    ScrollView {
                        VStack(spacing: 16) {
                            ZStack(alignment: .topTrailing){
                                AsyncImage(url: URL(string: product.thumbnail)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Image("Placeholder")
                                        .resizable()
                                }
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .cornerRadius(32)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .foregroundStyle(Color(.backgroundsSecondary))
                                        .padding()
                                )
                                
                                FavoriteIcon(isFavorite: viewModel.isFavorite) {
                                    viewModel.favoriteToggle()
                                }
                                .padding()
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(product.title)
                                    .typography(.title3Regular)
                                    .padding(.top,8)
                                
                                let formattedPrice = String(format: "%.2f", product.price)
                                Text("US$ \(formattedPrice)")
                                    .typography(.title2Emphasized)
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(product.description)
                                .typography(.bodyRegular)
                                .foregroundStyle(.labelsSecondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                        }
                        .padding()
                    }
                    
                    Text("Add to Cart")
                        .typography(.bodyEmphasized)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(.fillsTertiary))
                        )
                        .onTapGesture {
                            dismiss()
                        }
                        .padding(.horizontal)
                }
            }
            .background(Color.backgroundsPrimary)
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.backgroundsSecondary, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .task {
                await viewModel.fetchProduct(id: id)
            }
        }
    }
}
