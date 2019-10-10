//
//  Homeworld.swift
//  starwar
//
//  Created by Panupong Kukutapan on 11/10/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import Foundation
import Gloss

struct Homeworld: JSONDecodable {
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    
    init?(json: JSON) {
        guard let name: String = "name" <~~ json else { return nil }
        self.name = name
        
        guard let rotationPeriod: String = "rotation_period" <~~ json else { return nil }
        self.rotationPeriod = rotationPeriod
        
        guard let orbitalPeriod: String = "orbital_period" <~~ json else { return nil }
        self.orbitalPeriod = orbitalPeriod
    }
}
