//
//  DetailsView.swift
//  APIRequest
//
//  Created by Gabriel Barbosa on 15/08/25.
//

import SwiftUI

struct DetailsView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(CartViewModel.self) var cart: CartViewModel
    
    let product: Product
    
    @State var viewModel: DetailsViewModel = DetailsViewModel(favoriteService: FavoriteService())
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .padding()
                } else {
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
                                    viewModel.favoriteToggle(product: product)
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
                            cart.addProduct(product: product)
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
            .onAppear {
                viewModel.checkIsFavorite(product: product)
            }
        }
    }
}
