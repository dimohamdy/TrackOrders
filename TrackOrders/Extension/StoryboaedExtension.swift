//
//  StoryboaedExtension.swift
//  GallaryApp
//
//  Created by BinaryBoy on 9/9/18.
//  Copyright © 2018 BinaryBoy. All rights reserved.
//

import UIKit

enum AppStoryboard: String {
    case gallary = "Gallary"
}

extension UIStoryboard {
    class func instantiateInitialViewController(_ board: AppStoryboard) -> UIViewController {
        let story = UIStoryboard(name: board.rawValue, bundle: nil)
        return story.instantiateInitialViewController()!
    }
}
