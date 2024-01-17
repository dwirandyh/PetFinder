//
//  PetFinderApp.swift
//  PetFinder
//
//  Created by Dwi Randy H on 16/01/24.
//

import SwiftUI

@main
struct PetFinderApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                AnimalListPage(viewModel: AnimalListViewModel.create())
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
            }
        }
    }
}
