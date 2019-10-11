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
    var next: String? = nil
    var previous: String? = nil
    let results: [Person]
    
    init?(json: JSON) {
        guard let count: Int = "count" <~~ json else { return nil }
        self.count = count
        
        if let next: String = "next" <~~ json {
            self.next = next.getId(by: -1)
        }
        
        if let previous: String =  "previous" <~~ json {
            self.previous = previous.getId(by: -1)
        }
        
        guard let results: [Person] = "results" <~~ json else { return nil }
        self.results = results
    }
}
