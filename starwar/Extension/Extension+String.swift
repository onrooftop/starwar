//
//  Extension.swift
//  starwar
//
//  Created by Panupong Kukutapan on 11/10/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import Foundation

extension String {
    func getId(by offset: Int = -2) -> String {
        //https://swapi.co/api/planets/1/ -> return 1
        let idChar = self[self.index(self.endIndex, offsetBy: offset)]
        
        return "\(idChar)"
    }
}
