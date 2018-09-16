//
//  Constant.swift
//  GallaryApp
//
//  Created by BinaryBoy on 9/3/18.
//  Copyright © 2018 BinaryBoy. All rights reserved.
//

import Foundation

enum API : String {
    case deliveries = "deliveries"
    
    var url:String {
        return API.domain + self.rawValue
    }
    //FIXME:Please change ip address of the server
    static let domain:String = "http://127.0.0.1:8080/"

}
