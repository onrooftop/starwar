//
//  APIManager.swift
//  starwar
//
//  Created by Panupong Kukutapan on 9/10/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import Gloss

protocol NetworkSession {
    @discardableResult
    func request(router: Router) -> Single<JSON>
}

class APIManager: NetworkSession {

    static let shared = APIManager()
    
    private init() {}

    @discardableResult
    func request(router: Router) -> Single<JSON> {
        
        return Single.create { (single) -> Disposable in
            
            Alamofire.request(router).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    single(.success(value as! JSON))
                    
                    
                case .failure(let error):
                    single(.error(error))
                }
            }
            
            return Disposables.create()
        }
        

    }
    
}
