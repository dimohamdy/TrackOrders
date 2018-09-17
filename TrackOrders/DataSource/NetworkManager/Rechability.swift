//
//  Rechability.swift
//  TrackOrders
//
//  Created by BinaryBoy on 9/16/18.
//  Copyright © 2018 BinaryBoy. All rights reserved.
//

import Alamofire


class Reachability {
    

    static let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    
    static func startNetworkReachabilityObserver() {
        
        if isConnected == false {
            Banner.shared.showAlert("⚠ The network is not reachable")
        }
        reachabilityManager?.listener = { status in
            switch status {
            case .notReachable:
                Banner.shared.showAlert("⚠ The network is not reachable")
            case .unknown : break
            //print("It is unknown whether the network is reachable")
            case .reachable(.ethernetOrWiFi):
                //print("The network is reachable over the WiFi connection")
                fallthrough
            case .reachable(.wwan):
                //print("The network is reachable over the WWAN connection")
                Banner.shared.hide(bannerType: .internet)
            }
        }
        
        // start listening
        reachabilityManager?.startListening()
    }
    
    static var isConnected: Bool {
        guard let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com") else { return false }
        
        return reachabilityManager.isReachable
    }
}
