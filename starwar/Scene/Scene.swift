//
//  Scene.swift
//  starwar
//
//  Created by Panupong Kukutapan on 11/10/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import UIKit

enum Scene {
    case list(StarwarListViewModel)
}

extension Scene {
    func viewController() -> UIViewController {
        switch self {
        case .list(let viewModel):
            var vc = StarwarListViewController()
            vc.bind(viewModel: viewModel)
            let nc = UINavigationController(rootViewController: vc)
            return nc
        }
    }
}
