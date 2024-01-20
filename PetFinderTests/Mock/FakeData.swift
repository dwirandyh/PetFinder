//
//  FakeData.swift
//  PetFinderTests
//
//  Created by Dwi Randy H on 20/01/24.
//

@testable import PetFinder
import Foundation

extension Animal {
    static let fakeAnimal: Animal = Animal(
        name: "African Bush Elephant",
        kingdom: "Animalia",
        phylum: "Chordata",
        taxonomyClass: "Mammalia",
        order: "Proboscidea",
        family: "Elephantidae",
        genus: "Loxodonta",
        scientificName: "Loxodonta africana africana",
        location: ["Africa"]
    )
    
    static let fakeAnimals: [Animal] = [
        Animal(
            name: "African Bush Elephant",
            kingdom: "Animalia",
            phylum: "Chordata",
            taxonomyClass: "Mammalia",
            order: "Proboscidea",
            family: "Elephantidae",
            genus: "Loxodonta",
            scientificName: "Loxodonta africana africana",
            location: ["Africa"]
        ),
        
        Animal(
            name: "African Forest Elephant",
            kingdom: "Animalia",
            phylum: "Chordata",
            taxonomyClass: "Mammalia",
            order: "Proboscidea",
            family: "Elephantidae",
            genus: "Loxodonta",
            scientificName: "Loxodonta cyclotis",
            location: ["Africa"]
        ),
        
        Animal(
            name: "Asian Elephant",
            kingdom: "Animalia",
            phylum: "Chordata",
            taxonomyClass: "Mammalia",
            order: "Proboscidea",
            family: "Elephantidae",
            genus: "Elephas",
            scientificName: "Elephas maximus",
            location: ["Asia"]
        ),
        
        Animal(
            name: "Borneo Elephant",
            kingdom: "Animalia",
            phylum: "Chordata",
            taxonomyClass: "Mammalia",
            order: "Proboscidea",
            family: "Elephantidae",
            genus: "Elephas",
            scientificName: "Elephas maximus borneensis",
            location: [
                "Asia",
                "Ocean"
            ]
        )
    ]
}

extension AnimalCategory {
    static let fakeAnimalCategory: AnimalCategory = AnimalCategory(
        name: "Elephant",
        imageName: "IconElephant"
    )
    
    static let fakeAnimalCategories: [AnimalCategory] = [
        AnimalCategory(
            name: "Elephant",
            imageName: "IconElephant"
        ),
        AnimalCategory(
            name: "Lion",
            imageName: "IconLion"
        ),
        AnimalCategory(
            name: "Fox",
            imageName: "IconFox"
        ),
        AnimalCategory(
            name: "Dog",
            imageName: "IconDog"
        ),
        AnimalCategory(
            name: "Shark",
            imageName: "IconShark"
        ),
        AnimalCategory(
            name: "Turtle",
            imageName: "IconTurtle"
        ),
        AnimalCategory(
            name: "Whale",
            imageName: "IconWhale"
        ),
        AnimalCategory(
            name: "Penguin",
            imageName: "IconPenguin"
        )
    ]
}

extension AnimalPhoto {
    static let fakePhoto: AnimalPhoto = AnimalPhoto(
        id: 1,
        photographer: "John Doe",
        photographerURL: URL(
            string: "https://example.com/johndoe"
        ),
        source: PhotoSource(
            original: "https://example.com/original1",
            large: "https://example.com/large1",
            medium: "https://example.com/medium1",
            small: "https://example.com/small1",
            portrait: "https://example.com/portrait1",
            landscape: "https://example.com/landscape1",
            tiny: "https://example.com/tiny1"
        )
    )
    
    static let fakePhotos: [AnimalPhoto] = [
        AnimalPhoto(
            id: 1,
            photographer: "John Doe",
            photographerURL: URL(
                string: "https://example.com/johndoe"
            ),
            source: PhotoSource(
                original: "https://example.com/original1",
                large: "https://example.com/large1",
                medium: "https://example.com/medium1",
                small: "https://example.com/small1",
                portrait: "https://example.com/portrait1",
                landscape: "https://example.com/landscape1",
                tiny: "https://example.com/tiny1"
            )
        ),
        AnimalPhoto(
            id: 2,
            photographer: "Jane Smith",
            photographerURL: URL(
                string: "https://example.com/janesmith"
            ),
            source: PhotoSource(
                original: "https://example.com/original2",
                large: "https://example.com/large2",
                medium: "https://example.com/medium2",
                small: "https://example.com/small2",
                portrait: "https://example.com/portrait2",
                landscape: "https://example.com/landscape2",
                tiny: "https://example.com/tiny2"
            )
        ),
    ]
}
