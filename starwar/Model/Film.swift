//
//  Film.swift
//  starwar
//
//  Created by Panupong Kukutapan on 11/10/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import Foundation
import Gloss

struct Film: JSONDecodable {
    let title: String
    let episodeId: Int
    
    init?(json: JSON) {
        guard let title: String = "title" <~~ json else { return nil }
        self.title = title
        
        guard let episodeId: Int = "episode_id" <~~ json else { return nil }
        self.episodeId = episodeId
    }
}
