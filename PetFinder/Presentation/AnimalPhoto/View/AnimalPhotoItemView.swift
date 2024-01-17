//
//  AnimalPhotoItemView.swift
//  PetFinder
//
//  Created by Dwi Randy H on 17/01/24.
//

import SwiftUI

struct AnimalPhotoItemView: View {
    let photo: AnimalPhoto
    let isFavorite: Bool
    
    @State
    var width: CGFloat = .zero
    
    init(photo: AnimalPhoto, isFavorite: Bool = false) {
        self.photo = photo
        self.isFavorite = isFavorite
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Rectangle()
                    .foregroundColor(Color.accentColor)
                    .onAppear {
                        width = proxy.size.width
                    }
                
                photographerView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
        }
        .frame(height: width / 1.77)
        .clipped()
    }
    
    func photographerView() -> some View {
        HStack {
            Text(photo.photographer)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
            
            Spacer()
            
            Button {
                
            } label: {
                if isFavorite {
                    Image(systemName: "star.fill")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.yellow)
                }
                else {
                    Image(systemName: "star")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.white)
                        .frame(width: 24, height: 24)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.black.opacity(0.4))
    }
}

#Preview {
    ScrollView {
        AnimalPhotoItemView(
            photo: .init(
                id: 0,
                photographer: "Alexas Fotos",
                photographerURL: URL(string: "https://www.pexels.com/photo/close-up-photo-of-lion-s-head-2220336/"),
                photo: .init(
                    original: "https://images.pexels.com/photos/2220336/pexels-photo-2220336.jpeg",
                    large: "https://images.pexels.com/photos/2220336/pexels-photo-2220336.jpeg",
                    medium: "https://images.pexels.com/photos/2220336/pexels-photo-2220336.jpeg",
                    small: "https://images.pexels.com/photos/2220336/pexels-photo-2220336.jpeg",
                    portrait: "https://images.pexels.com/photos/2220336/pexels-photo-2220336.jpeg",
                    landspace: "https://images.pexels.com/photos/2220336/pexels-photo-2220336.jpeg",
                    tiny: "https://images.pexels.com/photos/2220336/pexels-photo-2220336.jpeg"
                )
            )
        )
    }
}
