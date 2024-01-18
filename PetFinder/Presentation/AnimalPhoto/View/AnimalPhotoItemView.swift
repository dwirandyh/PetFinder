//
//  AnimalPhotoItemView.swift
//  PetFinder
//
//  Created by Dwi Randy H on 17/01/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct AnimalPhotoItemView: View {
    let photo: AnimalPhoto
    let isFavorite: Bool
    let favoriteTapped: () -> Void
    
    @State
    var width: CGFloat = .zero
    
    init(photo: AnimalPhoto, isFavorite: Bool = false, favoriteTapped: @escaping () -> Void) {
        self.photo = photo
        self.isFavorite = isFavorite
        self.favoriteTapped = favoriteTapped
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                WebImage(url: URL(string: photo.source.medium))
                    .resizable()
                    .placeholder {
                        Rectangle().foregroundColor(.gray)
                    }
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFill()
                    .frame(width: width, height: width / 1.77)
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
            
            Button(action: favoriteTapped) {
                if isFavorite {
                    Image(systemName: "star.fill")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.yellow)
                        .frame(width: 24, height: 24)
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
                source: .init(
                    original: "https://images.pexels.com/photos/2220336/pexels-photo-2220336.jpeg?auto=compress&cs=tinysrgb&h=350",
                    large: "https://images.pexels.com/photos/2220336/pexels-photo-2220336.jpeg?auto=compress&cs=tinysrgb&h=350",
                    medium: "https://images.pexels.com/photos/2220336/pexels-photo-2220336.jpeg?auto=compress&cs=tinysrgb&h=350",
                    small: "https://images.pexels.com/photos/2220336/pexels-photo-2220336.jpeg?auto=compress&cs=tinysrgb&h=350",
                    portrait: "https://images.pexels.com/photos/2220336/pexels-photo-2220336.jpeg?auto=compress&cs=tinysrgb&h=350",
                    landspace: "https://images.pexels.com/photos/2220336/pexels-photo-2220336.jpeg?auto=compress&cs=tinysrgb&h=350",
                    tiny: "https://images.pexels.com/photos/2220336/pexels-photo-2220336.jpeg?auto=compress&cs=tinysrgb&h=350"
                )
            )
        ) {
            
        }
    }
}
