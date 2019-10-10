//
//  Starship.swift
//  starwar
//
//  Created by Panupong Kukutapan on 11/10/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import Foundation
import Gloss

struct Starship: JSONDecodable {
    let name: String
    let model: String
    let manufacturer: String
    
    init?(json: JSON) {
        guard let name: String = "name" <~~ json else { return nil }
        self.name = name
        
        guard let model: String = "model" <~~ json else { return nil }
        self.model = model
        
        guard let manufacturer: String = "manufacturer" <~~ json else { return nil }
        self.manufacturer = manufacturer
    }
}
