//
//  AnimalCategory.swift
//  PetFinder
//
//  Created by Dwi Randy H on 16/01/24.
//

import Foundation

struct AnimalCategory: Equatable {
    let name: String
    let imageName: String
}

extension AnimalCategory {
    static var predefined: [AnimalCategory] = [
        AnimalCategory(name: "Elephant", imageName: "IconElephant"),
        AnimalCategory(name: "Lion", imageName: "IconLion"),
        AnimalCategory(name: "Fox", imageName: "IconFox"),
        AnimalCategory(name: "Dog", imageName: "IconDog"),
        AnimalCategory(name: "Shark", imageName: "IconShark"),
        AnimalCategory(name: "Turtle", imageName: "IconTurtle"),
        AnimalCategory(name: "Whale", imageName: "IconWhale"),
        AnimalCategory(name: "Penguin", imageName: "IconPenguin")
    ]
    
    static var defaultSelectedCategory: AnimalCategory = AnimalCategory(name: "Elephant", imageName: "IconElephant")
}
