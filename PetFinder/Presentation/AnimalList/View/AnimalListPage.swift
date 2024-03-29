//
//  AnimalListPage.swift
//  PetFinder
//
//  Created by Dwi Randy H on 16/01/24.
//

import SwiftUI

struct AnimalListPage: View {
    
    @ObservedObject
    var viewModel: AnimalListViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            AnimalCategoryView(categories: viewModel.animalCategory, selectedCategory: viewModel.selectedAnimalCategory) { category in
                Task {
                    await viewModel.animalCategoryDidChange(category: category)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            
            ScrollView(showsIndicators: false) {
                switch viewModel.animalsResult {
                case .success(let animals):
                    ForEach(animals, id: \.name) { animal in
                        NavigationLink {
                            AnimalPhotoPage(viewModel: AnimalPhotoViewModel.create(animal: animal, category: viewModel.selectedAnimalCategory!))
                        } label: {
                            AnimalItemView(animal: animal)
                                .padding(8)
                        }
                        .buttonStyle(.plain)
                    }
                case .error:
                    ErrorView(
                        title: "Oppss.. Something went wrong",
                        message: "Failed to get data from server, please check internet connection and try again"
                    )
                    .padding(.top, 40)
                case .loading:
                    ActivityIndicator(style: .large)
                        .padding(.top, 40)
                }
                
            }
            .padding(.horizontal, 16)
        }
        .navigationBarTitle("Animal Finder", displayMode: .large)
        .background(Color.backgroundColor)
        .padding(.vertical, 16)
        .onLoad {
            Task {
                await viewModel.onLoad()
            }
        }
    }
}

#Preview {
    AnimalListPage(viewModel: AnimalListViewModel.create())
}
