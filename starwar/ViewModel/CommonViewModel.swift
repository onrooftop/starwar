//
//  CommonViewModel.swift
//  starwar
//
//  Created by Panupong Kukutapan on 11/10/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

class CommonViewModel: NSObject {
    
    let title: Driver<String>
    let sceneCoordinator: SceneCoordinator
    let apiManager: APIManager
    let storage: StarwarStorageType
    
    init(title: String, sceneCoordinator: SceneCoordinator, apiManager: APIManager = APIManager.shared, storage: StarwarStorageType) {
        self.title = Driver<String>.just(title)
        self.sceneCoordinator = sceneCoordinator
        self.apiManager = apiManager
        self.storage = storage
    }
}
