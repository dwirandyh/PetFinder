//
//  AnimalCategoryItemView.swift
//  PetFinder
//
//  Created by Dwi Randy H on 16/01/24.
//

import SwiftUI

struct AnimalCategoryItemView: View {
    let animal: AnimalCategory
    @State
    var isSelected: Bool = false
    
    var body: some View {
        Button {
            
        } label: {
            HStack(spacing: 4) {
                Image(animal.imageName)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .padding(.horizontal, 8)
                
                Text(animal.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(isSelected ? .cardSelectedTextColor : .black)
                    .padding(.trailing, 16)
            }
            .padding(.vertical, 8)
            .background(.cardBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        }
    }
}

#Preview {
    AnimalCategoryItemView(animal: .predefined.first!)
        .padding(16)
        .background(.backgroundColor)
}
