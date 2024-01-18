//
//  FavoritePage.swift
//  PetFinder
//
//  Created by Dwi Randy H on 18/01/24.
//

import SwiftUI

struct FavoritePage: View {
    @ObservedObject
    var viewModel: FavoriteViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            AnimalCategoryView(categories: viewModel.animalCategory, selectedCategory: viewModel.selectedAnimalCategory) { category in
                Task {
                    viewModel.animalCategoryDidChange(category: category)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            
            VStack {
                switch viewModel.animalPhotoResult {
                case .success(let photos):
                    if photos.isEmpty {
                        ErrorView(title: "Empty Favorite Photo", message: "Uh-oh! It appears that your favorite photo selection is empty.")
                            .padding(16)
                    } else {
                        List(photos) { photo in
                            AnimalPhotoItemView(photo: photo, isFavorite: true) {
                                viewModel.removeFavoriteTapped(photo: photo)
                            }
                        }
                        .listStyle(.plain)
                    }
                case .error:
                    ErrorView(
                        title: "Oppss.. Something went wrong",
                        message: "Failed to get data from server, please check internet connection and try again"
                    )
                    .padding(.top, 40)
                    .padding(.horizontal, 16)
                case .loading:
                    ActivityIndicator(style: .large)
                        .padding(.top, 40)
                        .padding(.horizontal, 16)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color.backgroundColor)
        .padding(.vertical, 16)
        .onAppear {
            viewModel.refreshData()
        }
        .onLoad {
            Task {
                await viewModel.onLoad()
            }
        }
    }
}
