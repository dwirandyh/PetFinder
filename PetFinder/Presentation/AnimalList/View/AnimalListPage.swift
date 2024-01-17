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
            Text("Animal Finder")
                .font(.system(size: 24, weight: .bold))
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            AnimalCategoryView(selectedCategory: viewModel.selectedAnimalCategory) { category in
                Task {
                    await viewModel.fetchAnimals(category: category)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.animals, id: \.name) { animal in
                    NavigationLink {
                        AnimalPhotoPage(viewModel: AnimalPhotoViewModel.create(animal: animal))
                    } label: {
                        AnimalItemView(animal: animal)
                            .padding(8)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
        }
        .navigationBarHidden(true)
        .background(Color.backgroundColor)
        .padding(.vertical, 16)
        .onAppear {
            Task {
                await viewModel.fetchAnimals()
            }
        }
    }
}

#Preview {
    AnimalListPage(viewModel: AnimalListViewModel.create())
}
