//
//  OrderDetailsViewModel.swift
//  TrackOrders
//
//  Created by BinaryBoy on 9/15/18.
//  Copyright (c) 2018 BinaryBoy. All rights reserved.
//

import RxSwift

class OrderDetailsViewModel:BaseViewModel {

    // input
    var order:Order!
    
    // output

    // internal

    init(order:Order) {
        self.order = order
        super.init()
        setupRx()
    }
}

// MARK: Setup
private extension OrderDetailsViewModel {

    func setupRx() {

    }
}
