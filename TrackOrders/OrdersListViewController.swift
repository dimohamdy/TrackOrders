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

class OrdersListViewController: BaseViewController {
    fileprivate let viewModel: OrdersListViewModel
    fileprivate let router: OrdersListRouter
    fileprivate let disposeBag = DisposeBag()
    private var tableView: UITableView!

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
        viewModel.getOrders()
        tableView = UITableView()
        tableView.estimatedRowHeight = 120.0;
        tableView.rowHeight = UITableViewAutomaticDimension;
        
        tableView.frame = self.view.frame
        tableView.register(OrderTableViewCell.self, forCellReuseIdentifier: OrderTableViewCell.id)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(0)
            make.left.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(0)
            make.right.equalTo(self.view).offset(0)
        }
        
        
        tableView.addSubview(activity)
        
        tableView.delegate = nil
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.ordersRX.asObservable().map({ (photos) -> Bool in
            return photos.count <= 0
        }).asObservable().bind(to: tableView.rx.isHidden).disposed(by: disposeBag)
        
        viewModel.ordersRX.asObservable().bind(to: tableView!.rx.items(cellIdentifier: OrderTableViewCell.id, cellType: OrderTableViewCell.self)) { row, cellData, cell in
            
            cell.configureCellWith(order: cellData, delegate: self)
            
            cell.delegate = self as! OrdereCellAction
            
            }.disposed(by: disposeBag)
        
        
        viewModel.loading.asObservable().share().bind(to: activity.rx_animating).disposed(by: disposeBag)
        
        
        tableView.rx.modelSelected(Order.self).subscribe(onNext: { order in
            //show order
            self.router.navigateToOrderDetails(order: order)
        }).disposed(by: self.disposeBag)
   

    }

    
    func setupLayout() {
    
    }

    func setupRx() {
    
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
        let configuration = ImageViewerConfiguration { config in
            config.imageView = imageView
        }
        
        self.present(ImageViewerController(configuration: configuration), animated: true)
        
    }
}
