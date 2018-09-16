//
//  UIImageViewExtension.swift
//  GallaryApp
//
//  Created by BinaryBoy on 9/4/18.
//  Copyright © 2018 BinaryBoy. All rights reserved.
//

import UIKit
import AlamofireImage

extension UIImageView {
    func setImageWith(_ path: String?, completion:((_ image: UIImage?) -> Void)? = nil) -> Void {
        image = nil
        guard let url = URL(string:path!) else {
            return
        }
        self.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "lalamove"), filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: UIImageView.ImageTransition.crossDissolve(0.25), runImageTransitionIfCached: false) {completion?($0.result.value)}
    }
}
