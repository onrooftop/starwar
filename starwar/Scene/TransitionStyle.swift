//
//  TransitionStyle.swift
//  starwar
//
//  Created by Panupong Kukutapan on 11/10/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import Foundation

enum TransitionStyle {
    case root
    case push(animated: Bool)
    case modal(animated: Bool)
}

enum TransitionError: Error {
    case cannotPush
    case cannotPop
    case unknow
}
