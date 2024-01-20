//
//  ErrorView.swift
//  PetFinder
//
//  Created by Dwi Randy H on 18/01/24.
//

import SwiftUI

struct ErrorView: View {
    let title: String
    let message: String
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color.accentColor)
            
            Text(message)
                .multilineTextAlignment(.center)
        }
    }
}
