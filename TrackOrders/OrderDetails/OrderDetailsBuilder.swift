//
//  OrderDetailsBuilder.swift
//  TrackOrders
//
//  Created by BinaryBoy on 9/15/18.
//  Copyright (c) 2018 BinaryBoy. All rights reserved.
//

import UIKit

struct OrderDetailsBuilder {

    static func viewController(order:Order) -> OrderDetailsViewController {
        let viewModel = OrderDetailsViewModel(order: order)
        let router = OrderDetailsRouter()
        let viewController = OrderDetailsViewController(withViewModel: viewModel, router: router)
        router.viewController = viewController

        return viewController
    }
}
