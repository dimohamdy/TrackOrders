//
//  OrdersListViewController.swift
//  TrackOrders
//
//  Created by BinaryBoy on 9/14/18.
//  Copyright (c) 2018 BinaryBoy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import SimpleImageViewer
import HGPlaceholders

class OrdersListViewController: BaseViewController {
    fileprivate let viewModel: OrdersListViewModel
    fileprivate let router: OrdersListRouter
    fileprivate let disposeBag = DisposeBag()
    private var tableView: TableView!
    
    var placeholderTableView: TableView?
    
    
    init(withViewModel viewModel: OrdersListViewModel, router: OrdersListRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupLayout()
        setupRx()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.insertSubview(activity, aboveSubview: tableView)
        
    }
}

// MARK: Setup
private extension OrdersListViewController {
    
    func setupViews() {
        title = "Things to Deliver"
        
        tableView = TableView()

        self.tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 120.0;
        tableView.rowHeight = UITableViewAutomaticDimension;
        
        tableView.frame = self.view.frame
        tableView.register(OrderTableViewCell.self, forCellReuseIdentifier: OrderTableViewCell.id)
        self.view.addSubview(tableView)
        tableView.addSubview(activity)
                
    }
    
    func activePlaceholderTableView(active:Bool) {
        
        if active {
            self.placeholderTableView = self.tableView
            self.placeholderTableView?.placeholdersProvider = .basic
            self.placeholderTableView?.placeholderDelegate = self
            self.placeholderTableView?.showNoResultsPlaceholder()
            
        } else {
            self.placeholderTableView?.placeholderDelegate = nil
            self.placeholderTableView?.dataSource = nil
            self.placeholderTableView?.delegate = nil
        }
    }
    
    func setupLayout() {
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(0)
            make.left.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(0)
            make.right.equalTo(self.view).offset(0)
        }
        
    }
    
    func setupRx() {
        
        let noReaultObservable:Observable<Bool> =  viewModel.ordersRX.asObservable().map({ (orders) -> Bool in
            return orders.count <= 0
        }).asObservable().share()
        
        
        noReaultObservable.subscribe(onNext: { [unowned self] noResult in
            
            if noResult == true {
                self.activePlaceholderTableView(active: true)
            } else {
                
                self.activePlaceholderTableView(active: false)
                
                self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
                
                self.viewModel.ordersRX.asObservable().bind(to: self.tableView!.rx.items(cellIdentifier: OrderTableViewCell.id, cellType: OrderTableViewCell.self)) { row, cellData, cell in
                    
                    cell.configureCellWith(order: cellData, delegate: self)
                    
                    }.disposed(by: self.disposeBag)
                
            }
        }).disposed(by: disposeBag)
        
        
        viewModel.loading.asObservable().share().bind(to: activity.rx_animating).disposed(by: disposeBag)
        
        
        tableView.rx.modelSelected(Order.self).subscribe(onNext: { order in
            //show order
            self.router.navigateToOrderDetails(order: order)
        }).disposed(by: self.disposeBag)
        
        viewModel.getOrders()
    }
}
// MARK: - UITableViewDelegate
extension OrdersListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 // But we have to return actual value here :(
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.loadMoreData(indexPath)
    }
}

extension OrdersListViewController : OrdereCellAction {
    
    func showOrderImage(imageView: UIImageView) {
        
        self.showImage(imageView: imageView)
    }
}

extension OrdersListViewController: PlaceholderDelegate {
    
    func view(_ view: Any, actionButtonTappedFor placeholder: Placeholder) {
        print(placeholder.key.value)
        viewModel.getOrders()
    }
    
}

