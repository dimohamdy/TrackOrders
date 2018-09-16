//
//  DataSource.swift
//  TrackOrders
//
//  Created by BinaryBoy on 9/16/18.
//  Copyright © 2018 BinaryBoy. All rights reserved.
//

import Foundation

protocol DataSource {
    func getOrders(offset:Int,limit:Int,completion:@escaping ([Order]?) -> Void)
}
