//
//  ServerManager.swift
//  GallaryApp
//
//  Created by BinaryBoy on 9/3/18.
//  Copyright © 2018 BinaryBoy. All rights reserved.
//

import Alamofire

class ServerManager : DataSource {
    let database:DataBaseManager!
    init(database:DataBaseManager) {
        self.database = database
    }
    func getOrders(offset:Int,limit:Int,completion:@escaping ([Order]?) -> Void){

        Alamofire.request(API.deliveries.url,
                          method: .get,
                          parameters: ["offset": offset,"limit":limit],
                          encoding: URLEncoding.queryString,
                          headers: nil).responseJSON { response in
                
                guard let data = response.data else { return }

                do {
                    let decoder = JSONDecoder()
                    let orders = try decoder.decode([Order].self, from: data)
                    self.database.save(orders: orders)
                    completion(orders)
                    print(orders.count)
                    
                } catch let err {
                    completion(nil)
                    print("Err", err)
                }
                
        }
    }
}

