//
//  StarwarListViewModel.swift
//  starwar
//
//  Created by Panupong Kukutapan on 11/10/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import Foundation
import RxSwift
import Gloss

class StarwarListViewModel: CommonViewModel {
    
    var endDrag: PublishSubject<Void>
    
    var isLoading: Observable<Bool>
    
    var personList: Observable<[Person]> {
        return storage.personList()
    }
    
    var people: Observable<People> {
        return storage.currentPeople()
    }
    
    private var jsonResponse: Observable<JSON>
    
    let disposeBag = DisposeBag()
    
    override init(title: String, sceneCoordinator: SceneCoordinator, apiManager: APIManager = APIManager.shared, storage: StarwarStorageType) {
        
        endDrag = PublishSubject<Void>()
        isLoading = Observable.empty()
        jsonResponse = Observable.empty()
        
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
        
        
        jsonResponse = endDrag.withLatestFrom(people)
            .flatMapLatest { return apiManager.request(router: .people(parameters: ["page": $0.next ?? "0"])).catchErrorJustReturn([:]) }
 
        jsonResponse
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { (json) in
             storage.createPeople(json: json)
            })
            .disposed(by: disposeBag)
        
        apiManager.request(router: .people(parameters: ["page": 1]))
            .subscribeOn(MainScheduler.instance)
            .subscribe(onSuccess: { (json) in
                storage.createPeople(json: json)
            })
            .disposed(by: disposeBag)
        
        isLoading = Observable.merge(
            endDrag.map { _ in true },
            jsonResponse.map { _ in false}
        ).startWith(true)
        

        
    }
    
}
