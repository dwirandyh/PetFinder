//
//  PetFinderApp.swift
//  PetFinder
//
//  Created by Dwi Randy H on 16/01/24.
//

import SwiftUI

struct PetFinderApp: View {
    var body: some View {
        TabView {
            AnimalListPage(viewModel: AnimalListViewModel.create())
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
        }
    }
}
