//
//  People.swift
//  starwar
//
//  Created by Panupong Kukutapan on 9/10/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import Foundation
import Gloss
struct People: JSONDecodable {

    let count: Int
    let next: String?
    let previous: String?
    let results: [Person]
    
    init?(json: JSON) {
        guard let count: Int = "count" <~~ json else { return nil }
        self.count = count
        
        self.next = "next" <~~ json
        self.previous = "previous" <~~ json
        
        guard let results: [Person] = "results" <~~ json else { return nil }
        self.results = results
    }
}
