//
//  ViewController.swift
//  starwar
//
//  Created by Panupong Kukutapan on 8/10/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx

class StarwarListViewController: UIViewController, BindableType{

    //MAKR: UI Elements
    private var tableView = StarwarListViewController._tableView()
    private var activityIndicatorView = StarwarListViewController._activityIndicatorView()

    var viewModel: StarwarListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.personList
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { (row, person, cell) in
                cell.textLabel?.text = person.name
            }
        .disposed(by: rx.disposeBag)
        
        viewModel.isLoading
            .subscribe(onNext: { [weak self] (loading) in
                self?.tableView.tableFooterView?.isHidden = !loading
            })
            .disposed(by: rx.disposeBag)
        
        viewModel.isLoading
            .bind(to: activityIndicatorView.rx.isAnimating)
            .disposed(by: rx.disposeBag)
        
        
            
        tableView.rx.willDisplayCell
            .flatMap({ (cell, indexPath) -> Observable<Bool> in
                let lastSectionIndex = indexPath.section == self.tableView.numberOfSections - 1
                let lastRowIndex = indexPath.row + 1 == self.tableView.numberOfRows(inSection: indexPath.section) - 1
                return Observable.just(lastSectionIndex && lastRowIndex)
            })
            .filter { $0 == true }
            .map{ _ in }
            .bind(to: viewModel.endDrag)
            .disposed(by: rx.disposeBag)
            
    }
}

//MARK: - UI Elements
extension StarwarListViewController {
    
    func setupViews() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //MARK: Table View
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //MARK: ActivityIndicator
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44))
        view.backgroundColor = UIColor.init(white: 1, alpha: 1)
        tableView.tableFooterView = view
        tableView.tableFooterView?.isHidden = true
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    class func _tableView() -> UITableView {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }
    
    class func _activityIndicatorView() -> UIActivityIndicatorView {
        let ai = UIActivityIndicatorView(style: .large)
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.color = .darkGray
        return ai
    }
    
}

