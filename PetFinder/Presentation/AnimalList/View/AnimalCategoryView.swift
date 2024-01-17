//
//  AnimalCategoryView.swift
//  PetFinder
//
//  Created by Dwi Randy H on 16/01/24.
//

import SwiftUI

struct AnimalCategoryView: View {
    let selectedCategory: AnimalCategory?
    let categoryTapped: (AnimalCategory) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(AnimalCategory.predefined.indices, id: \.self) { index in
                    let category: AnimalCategory = AnimalCategory.predefined[index]
                    AnimalCategoryItemView(category: category, isSelected: category == selectedCategory) {
                        categoryTapped(category)
                    }
                    .padding(.leading, index == 0 ? 16 : 0)
                    .padding(.trailing, index == AnimalCategory.predefined.count - 1 ? 16 : 0)
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        AnimalCategoryView(selectedCategory: .defaultSelectedCategory) { _ in
        }
    }
}
