//
//  SceneCoordinator.swift
//  starwar
//
//  Created by Panupong Kukutapan on 11/10/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import UIKit
import RxSwift

protocol SceneCoordinatorType {
    
    init(window: UIWindow)
    
    var currentViewController: UIViewController { get }
    
    func transition(to scene: Scene, using style: TransitionStyle) -> Completable
    
    func close(animated: Bool) -> Completable
}

extension UIViewController {
    func sceneViewController() -> UIViewController {
        return self.children.first ?? self
    }
}

class SceneCoordinator: SceneCoordinatorType {
    
    private let window: UIWindow!
    
    var currentViewController: UIViewController
   
    required init(window: UIWindow) {
        currentViewController = window.rootViewController!
        self.window = window
    }
    
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle) -> Completable {
        
        let subject = PublishSubject<Void>()
        let target = scene.viewController()
        
        switch style {
        case .root:
            window.rootViewController = target
            currentViewController = target.sceneViewController()
            subject.onCompleted()
        case .push(let animated):
            guard let navigationController = currentViewController.navigationController else {
                subject.onError(TransitionError.cannotPush)
                break
            }
            
            navigationController.pushViewController(target, animated: animated)
            currentViewController = target.sceneViewController()
            subject.onCompleted()
            
        case .modal(let animated):
            currentViewController.present(target, animated: animated) {
                subject.onCompleted()
            }
            currentViewController = target.sceneViewController()
        }
        
        return subject.ignoreElements()
        
    }
    
    @discardableResult
    func close(animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()
        
        //Modal
        if let presentingViewController = currentViewController.presentingViewController {
            currentViewController.dismiss(animated: animated) {
                subject.onCompleted()
            }
            
            currentViewController = presentingViewController.sceneViewController()
        //Nav
        } else if let navigationController = currentViewController.navigationController {
            guard navigationController.popViewController(animated: animated) != nil else {
                subject.onError(TransitionError.cannotPop)
                return subject.ignoreElements()
            }
            
            currentViewController = navigationController.viewControllers.last!
            
            subject.onCompleted()
        } else {
            subject.onError(TransitionError.unknow)
        }
        
        return subject.ignoreElements()
    }
    
    
}
