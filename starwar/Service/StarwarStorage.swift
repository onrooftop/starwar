//
//  StarwarStorage.swift
//  starwar
//
//  Created by Panupong Kukutapan on 11/10/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import Foundation
import RxSwift
import Gloss

protocol StarwarStorageType {
    @discardableResult
    func createPeople(json: JSON) -> Observable<People>
    
    @discardableResult
    func currentPeople() -> Observable<People>
    
    @discardableResult
    func personList() -> Observable<[Person]>
}

class StarwarStorage: StarwarStorageType {

    
    private var list: [Person] = []
    private var people: People? = nil
    
    private lazy var listObserver = BehaviorSubject<[Person]>(value: list)
    private lazy var peopleObserver = PublishSubject<People>()
    
    @discardableResult
    func createPeople(json: JSON) -> Observable<People> {
        self.people = People(json: json)
        
        guard let people = self.people else { return Observable.empty() }
        
        list.append(contentsOf: people.results)
        
        peopleObserver.onNext(people)
        listObserver.onNext(list)
        
        return Observable.just(people)
    }
    
    @discardableResult
    func currentPeople() -> Observable<People> {
        return peopleObserver
    }
    
    @discardableResult
    func personList() -> Observable<[Person]> {
        return listObserver
    }
    

    
}
