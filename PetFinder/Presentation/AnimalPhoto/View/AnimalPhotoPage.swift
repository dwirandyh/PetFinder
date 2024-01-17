//
//  AnimalPhotoPage.swift
//  PetFinder
//
//  Created by Dwi Randy H on 17/01/24.
//

import SwiftUI

struct AnimalPhotoPage: View {
    
    @ObservedObject
    var viewModel: AnimalPhotoViewModel
    
    init(viewModel: AnimalPhotoViewModel) {
        self.viewModel = viewModel
        
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        VStack {
            if viewModel.photos.isEmpty && viewModel.isLoading {
                ActivityIndicator(isAnimating: $viewModel.isLoading, style: .large)
            } else {
                List(viewModel.photos) { photo in
                    AnimalPhotoItemView(photo: photo)
                        .onAppear {
                            if photo == viewModel.photos.last {
                                Task {
                                    await viewModel.findNextPhoto()
                                }
                            }
                        }
                }
                .listStyle(.plain)
            }
        }
        .navigationBarTitle("Discover Animal Photos", displayMode: .inline)
        .onAppear {
            Task {
                await viewModel.findAnimalPhoto()
            }
        }
    }
}

#Preview {
    AnimalPhotoPage(
        viewModel: AnimalPhotoViewModel(
            animal: Animal(
                name: "Cheetah",
                kingdom: "Animalia",
                phylum: "Chordata",
                taxonomyClass: "Mammalia",
                order: "Carnivora",
                family: "Felidae",
                genus: "Acinonyx",
                scientificName: "Acinonyx jubatus",
                location: ["Africa"]
            ),
            repository: AnimalRepositoryImpl.create()
        )
    )
}
