//
//  DataBaseManagerTests.swift
//  TrackOrdersTests
//
//  Created by BinaryBoy on 9/17/18.
//  Copyright © 2018 BinaryBoy. All rights reserved.
//

import Quick
import Nimble
import RealmSwift

@testable import TrackOrders

class DataBaseManagerTests: QuickSpec {
    var database:DataBaseManager!
    var realm: Realm!
    
    override func spec() {
        
        describe("DatabaseManager") {
            beforeEach {
                self.database = DataBaseManager()
                self.realm = try! Realm()
                try! self.realm.write {
                    self.realm.deleteAll()
                }
            }
            context("Test number of orders from API"){
                it("expect get orders not empty array"){
                    
                    
                    self.database.getOrders(offset: 0, limit: 10, completion: { orders in
                        expect(orders?.count) == 10
                        
                    })
                    
                }
            }
            
            
            context("Test Save array to database"){
                it("expect number of order increase in database"){
                    
                    expect(self.realm.objects(Order.self).count).to(equal(0))
                    
                    let order = Order()
                    let location = Location()
                    location.address = "Mong Kok"
                    location.lat = 22.319181
                    location.lng = 114.170008
                    order.location = location
                    order.id = 8
                    order.descriptionField = "Deliver toys to Luqman"
                    order.imageUrl = "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-8.jpeg"
                    self.database.save(orders: [order])
                    
                    expect(self.realm.objects(Order.self).count).to(equal(1))
                    
                    
                }
            }
            
        }
    }
}

