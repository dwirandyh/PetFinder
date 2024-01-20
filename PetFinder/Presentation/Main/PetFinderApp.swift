//
//  PetFinderApp.swift
//  PetFinder
//
//  Created by Dwi Randy H on 16/01/24.
//

import SwiftUI

struct PetFinderApp: View {
    var body: some View {
//        NavigationView {
//            TabView {
//                AnimalListPage(viewModel: AnimalListViewModel.create())
//                    .tabItem {
//                        VStack {
//                            Image(systemName: "house")
//                            Text("Animals")
//                        }
//                    }
//                
//                FavoritePage(viewModel: FavoriteViewModel.create())
//                    .tabItem {
//                        VStack {
//                            Image(systemName: "star")
//                            Text("Favorite")
//                        }
//                    }
//            }
//        }
        
        TabBarView()
    }
}


struct TabBarView: View {
    
    @State var tabSelection: Int = 0
    
    var body: some View {
        NavigationView {
            TabView() {
                AnimalListPage(viewModel: AnimalListViewModel.create())
                    .tabItem {
                        VStack {
                            Image(systemName: "house")
                            Text("Animals")
                        }
                    }
                    .tag(0)
                
                FavoritePage(viewModel: FavoriteViewModel.create())
                    .tabItem {
                        VStack {
                            Image(systemName: "star")
                            Text("Favorite")
                        }
                    }
                    .tag(1)
            }
            .navigationBarTitle("Animal Finder")
        }
    }
}
struct DetailView: View {
    var body: some View {
        Text("Detail View")
            .navigationBarTitle("NavigatedView")
    }
}
