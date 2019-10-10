//
//  Specie.swift
//  starwar
//
//  Created by Panupong Kukutapan on 11/10/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import Foundation
import Gloss

struct Specie: JSONDecodable {
    let name: String
    let language: String
    
    init?(json: JSON) {
        guard let name: String = "name" <~~ json else { return nil }
        self.name = name
        
        guard let language: String = "language" <~~ json else { return nil }
        self.language = language
    }
}
