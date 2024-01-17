//
//  AnimalItemView.swift
//  PetFinder
//
//  Created by Dwi Randy H on 17/01/24.
//

import SwiftUI

struct AnimalItemView: View {
    let animal: Animal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(animal.name)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color.accentColor)
            
            if let scientificName = animal.scientificName {
                Text("(\(scientificName))")
            }
            
            Location(animal: animal)
            TaxonomyView(animal: animal)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color.cardBackgroundColor)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

private struct Location: View {
    let animal: Animal
    
    var body: some View {
        Text("Location")
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(Color.accentColor)
        
        Text(formattedLocation())
            .padding(.horizontal, 8)
    }
    
    private func formattedLocation() -> String {
        return animal.location.map { "• \($0) "}.joined()
    }
}


private struct TaxonomyView: View {
    let animal: Animal
    
    var body: some View {
        Text("Taxonomy")
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(Color.accentColor)
        
        VStack(alignment: .leading, spacing: 4) {
            if let kingdom = animal.kingdom {
                listItem(title: "Kingdom", value: kingdom)
            }
            
            if let phylum = animal.phylum {
                listItem(title: "Phylum", value: phylum)
            }
         
            if let taxonomyClass = animal.taxonomyClass {
                listItem(title: "Class", value: taxonomyClass)
            }
            
            if let order = animal.order {
                listItem(title: "Order", value: order)
            }
            
            if let family = animal.family {
                listItem(title: "Family", value: family)
            }
        }
        .padding(.horizontal, 8)
    }
    
    
    func listItem(title: String, value: String) -> some View {
        HStack(alignment: .top) {
            Text("•")
            Text("\(title):")
            Text(value)
        }
    }
}

#Preview {
    AnimalItemView(
        animal: .init(
            name: "Adelie Penguin",
            kingdom: "Animalia",
            phylum: "Chordata",
            taxonomyClass: "Aves",
            order: "Sphenisciformes",
            family: "Spheniscidae",
            genus: "Pygoscelis",
            scientificName: "Pygoscelis adeliae",
            location: ["Antarctica", "Asia", "Eurasia", "Ocean"]
        )
    )
    .padding(16)
}
