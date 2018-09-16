//
//  OrdersListBuilder.swift
//  TrackOrders
//
//  Created by BinaryBoy on 9/14/18.
//  Copyright (c) 2018 BinaryBoy. All rights reserved.
//

import UIKit

struct OrdersListBuilder {

    static func viewController() -> OrdersListViewController {
        let dataBaseManager = DataBaseManager()
        let viewModel = OrdersListViewModel(database: dataBaseManager)
        let router = OrdersListRouter()
        let viewController = OrdersListViewController(withViewModel: viewModel, router: router)
        router.viewController = viewController

        return viewController
    }
    
    static func navigationController() -> UINavigationController {

        return UINavigationController(rootViewController: OrdersListBuilder.viewController())
    }

}

