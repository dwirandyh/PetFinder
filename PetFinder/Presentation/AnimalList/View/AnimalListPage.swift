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
            AnimalCategoryView(selectedAnimal: viewModel.selectedAnimalCategory)
                .fixedSize(horizontal: false, vertical: true)
            
            ScrollView(showsIndicators: false) {
                Text("aa")
            }
        }
        .padding(16)
        .task {
//            await viewModel.fetchAnimals(animalCategory: .defaultSelectedCategory)
        }
    }
}

#Preview {
    AnimalListPage(viewModel: AnimalListViewModel.create())
}
