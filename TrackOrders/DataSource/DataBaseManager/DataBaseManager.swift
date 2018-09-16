//
//  DataBaseManager.swift
//  TrackOrders
//
//  Created by BinaryBoy on 9/16/18.
//  Copyright © 2018 BinaryBoy. All rights reserved.
//

import RealmSwift



class DataBaseManager: DataSource {
    
    func getOrders(offset:Int,limit:Int,completion:@escaping ([Order]?) -> Void){
        
        let realm = try! Realm()
        let orders = Array(realm.objects(Order.self))
        print("===== \(orders.count)")
        guard orders.count > 0  else {
            return
        }
        let beginIndex:Int = offset * limit
        var endIndex:Int = orders.count - 1

        let isBeginIndexValid = orders.indices.contains((beginIndex + limit))

        guard isBeginIndexValid == true else {
            return
        }
        let isEndIndexValid = orders.indices.contains((beginIndex + limit))

        if isEndIndexValid == true {
            endIndex = beginIndex + limit
        }
//        realm.objects(Order.self)[(beginIndex ..< endIndex)]

        let arrayOfOrders:[Order] =  Array(orders[(beginIndex ..< endIndex)])
        
        completion(arrayOfOrders)
        
    }
    
    func save(orders:[Order]){
        
        orders.forEach { order in
            do {
                
                try order.save()
            } catch let error {
                print(error)
            }
        }
        
    }
    
    
}

extension Object {
    
    /** Must be called from main thread */
    func save(_ update: Bool = true) throws {
        let realm = try! Realm()
        try realm.write() {
            realm.add(self, update: update)
        }
    }
    
}
