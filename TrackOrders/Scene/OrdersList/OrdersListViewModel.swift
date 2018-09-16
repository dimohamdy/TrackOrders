//
//  OrdersListViewModel.swift
//  TrackOrders
//
//  Created by BinaryBoy on 9/14/18.
//  Copyright (c) 2018 BinaryBoy. All rights reserved.
//

import RxSwift
import RxCocoa

class OrdersListViewModel : BaseViewModel {
    
    // input
    var database: DataBaseManager!
    var serverManager:ServerManager!
    // output
    var ordersRX  : BehaviorRelay<[Order]> = BehaviorRelay(value: [])
    
    // internal
    fileprivate var page = 0
    fileprivate var canLoadMore = true
    
    let limitOfItem = 10
    
    init(database: DataBaseManager) {
        super.init()
        self.database = database
        self.serverManager = ServerManager(database: database)
        setupRx()
        getOrders()
    }
    func loadMoreData(_ index: IndexPath) {
        let count =  self.ordersRX.value.count
        if count > 8, index.item == count - 5 && canLoadMore {
            page += 1
            getOrders()
        }
    }
    func getOrders(){
        self.loading.accept(true)
        
        var datasource:DataSource? = nil
        //check internet connection
        if Reachability.isConnected  == true {
            datasource = ServerManager(database: database)
        } else {
            datasource = database
            
        }
        
        datasource?.getOrders(offset: page,limit: limitOfItem) { ordersArray in
            // print(photos?.count)
            guard let orders = ordersArray else{
                return
            }
            self.loading.accept(false)
            var tempOrderArray = self.ordersRX.value
            tempOrderArray.append(contentsOf: orders)
            self.ordersRX.accept(tempOrderArray)
            
        }
        
    }
    
}

// MARK: Setup
private extension OrdersListViewModel {
    
    func setupRx() {
        
    }
}
