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
            switch viewModel.photoResult {
            case .success(let photos):
                List(photos) { photo in
                    AnimalPhotoItemView(photo: photo)
                        .onAppear {
                            if photo == photos.last {
                                Task {
                                    await viewModel.findNextPhoto()
                                }
                            }
                        }
                }
                .listStyle(.plain)
            case .loading:
                ActivityIndicator(style: .large)
            case .error:
                ErrorView(
                    title: "Opss.. Something went wrong",
                    message: "Failed to load photo, please try again alter"
                )
            }
        }
        .navigationBarTitle("Discover Animal Photos", displayMode: .inline)
        .onLoad {
            Task {
                await viewModel.onLoad()
            }
        }
    }
}

#Preview {
    AnimalPhotoPage(
        viewModel: AnimalPhotoViewModel.create(
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
            )
        )
    )
}
