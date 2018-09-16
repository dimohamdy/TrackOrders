//
//  Banner.swift
//  GallaryApp
//
//  Created by BinaryBoy on 9/6/18.
//  Copyright © 2018 BinaryBoy. All rights reserved.
//

import UIKit
import SwiftMessages

class Banner{
    static let shared =  Banner()
    var config = SwiftMessages.Config()
    
    private init(){
        config.presentationStyle = .top
        config.duration = .forever
        config.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
    }
    func showAlert(_ message: String) {
        
        let view = MessageView.viewFromNib(layout: .statusLine)
        view.id = BannerType.internet.rawValue
        view.configureTheme(backgroundColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), iconImage: nil, iconText: nil)
        
        view.button?.isHidden = true
        view.iconImageView?.isHidden = true
        view.iconLabel?.isHidden = true
        
        view.bodyLabel?.text = message
        SwiftMessages.show(config: config, view: view)
    }
    
    func hide(bannerType:BannerType) {
        // Get a message view with the given ID if is it currently
        // queued to be shown.
        SwiftMessages.hide(id: bannerType.rawValue)
    }
    
}
enum BannerType : String{
    case internet = "Internet"
}
