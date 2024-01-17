//
//  AnimalCategoryView.swift
//  PetFinder
//
//  Created by Dwi Randy H on 16/01/24.
//

import SwiftUI

struct AnimalCategoryView: View {
    let selectedAnimal: AnimalCategory?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(AnimalCategory.predefined.indices, id: \.self) { index in
                    let animal: AnimalCategory = AnimalCategory.predefined[index]
                    AnimalCategoryItemView(animal: animal, isSelected: animal == selectedAnimal)
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        AnimalCategoryView(selectedAnimal: .defaultSelectedCategory)
    }
}
