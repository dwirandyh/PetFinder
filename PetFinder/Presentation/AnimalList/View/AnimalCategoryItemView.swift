//
//  AnimalCategoryItemView.swift
//  PetFinder
//
//  Created by Dwi Randy H on 16/01/24.
//

import SwiftUI

struct AnimalCategoryItemView: View {
    let category: AnimalCategory
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action){
            HStack(spacing: 4) {
                Image(category.imageName)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .padding(.horizontal, 8)
                
                Text(category.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(isSelected ? .cardSelectedTextColor : .black)
                    .padding(.trailing, 16)
            }
            .padding(.vertical, 8)
            .background(Color.cardBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        }
    }
}

#Preview {
    AnimalCategoryItemView(category: .predefined.first!, isSelected: false) {
        
    }
    .padding(16)
}
