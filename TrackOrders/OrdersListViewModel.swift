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

    // output
    var ordersRX  : BehaviorRelay<[Order]> = BehaviorRelay(value: [])

    // internal
    fileprivate var page = 0
    fileprivate var canLoadMore = true
    
    let limitOfItem = 10
    
    override init() {
        super.init()
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
        ServerManager.getOrders(offset: page,limit: limitOfItem) { ordersArray in
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
