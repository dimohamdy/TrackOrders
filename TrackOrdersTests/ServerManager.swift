//
//  ServerManager.swift
//  TrackOrdersTests
//
//  Created by BinaryBoy on 9/16/18.
//  Copyright © 2018 BinaryBoy. All rights reserved.
//

import Quick
import Nimble

@testable import GallaryApp

class ServerManagerTest: QuickSpec {
    var server:ServerManager!
    
    override func spec() {
        
        describe("ServerManager") {
            beforeEach {
                self.server = ServerManager()
            }
            context("Test number of orders from API"){
                it("expect get orders not empty array"){
                    self.server.getOrders(completion: { orders in
                        expect(orders?.count)  > 0
                    })
                    
                }
            }
            
        }
    }
}
