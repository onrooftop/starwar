//
//  Person.swift
//  starwar
//
//  Created by Panupong Kukutapan on 9/10/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import Foundation
import Gloss

struct Person: JSONDecodable {
    let name: String
    let height: String
    let mass: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: String
    let gender: String
    let homeworldId: String
    let filmIds: [String]
    let specieIds: [String]
    let vehicleIds: [String]
    let starshipIds: [String]
    
    init?(json: JSON) {
        guard let name: String = "name" <~~ json else { return nil }
        self.name = name
        
        guard let height: String = "height" <~~ json else { return nil }
        self.height = height
        
        guard let mass: String = "mass" <~~ json else { return nil }
        self.mass = mass
        
        guard let hairColor: String = "hair_color" <~~ json else { return nil }
        self.hairColor = hairColor
        
        guard let skinColor: String = "skin_color" <~~ json else { return nil }
        self.skinColor = skinColor
        
        guard let eyeColor: String = "eye_color" <~~ json else { return nil }
        self.eyeColor = eyeColor
        
        guard let birthYear: String = "birth_year" <~~ json else { return nil }
        self.birthYear = birthYear
        
        guard let gender: String = "gender" <~~ json else { return nil }
        self.gender = gender
        
        guard let homeworld: String = "homeworld" <~~ json else { return nil }
        self.homeworldId = homeworld.getId()
        
        guard let films: [String] = "films" <~~ json else { return nil }
        self.filmIds = films.map { $0.getId() }
        
        guard let species: [String] = "species" <~~ json else { return nil }
        self.specieIds = species.map { $0.getId() }
        
        guard let vehicles: [String] = "vehicles" <~~ json else { return nil }
        self.vehicleIds = vehicles.map { $0.getId() }
        
        guard let starships: [String] = "starships" <~~ json else { return nil }
        self.starshipIds = starships.map { $0.getId() }
    }
        
}
