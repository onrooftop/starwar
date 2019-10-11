//
//  BindableType.swift
//  starwar
//
//  Created by Panupong Kukutapan on 11/10/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import Foundation

protocol BindableType {
    associatedtype ViewModel
    
    var viewModel: ViewModel! { get set }
    
    func bindViewModel()
}


extension BindableType {
    mutating func bind(viewModel: Self.ViewModel) {
        self.viewModel = viewModel
        bindViewModel()
    }
}
