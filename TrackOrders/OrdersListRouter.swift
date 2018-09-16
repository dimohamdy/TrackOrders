//
//  OrdersListRouter.swift
//  TrackOrders
//
//  Created by BinaryBoy on 9/14/18.
//  Copyright (c) 2018 BinaryBoy. All rights reserved.
//

import Foundation

class OrdersListRouter {
    weak var viewController: OrdersListViewController?

    func navigateToOrderDetails(order:Order) {
        let orderDetailsViewController:OrderDetailsViewController = OrderDetailsBuilder.viewController(order: order) 
        viewController?.navigationController?.pushViewController(orderDetailsViewController, animated: true)
            
    }
}
