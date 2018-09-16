//
//  OrderTableViewCell.swift
//  TrackOrders
//
//  Created by BinaryBoy on 9/14/18.
//  Copyright © 2018 BinaryBoy. All rights reserved.
//

import UIKit
import SnapKit

protocol OrdereCellAction : class {
    func showOrderImage(imageView:UIImageView)
}
class OrderTableViewCell: UITableViewCell,ReusableCellView {
    private var orderImage: UIImageView!
    private var descriptionLabel: UILabel!
    weak var delegate:OrdereCellAction!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none

        orderImage = UIImageView(image: #imageLiteral(resourceName: "lalamove"))
        descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        self.addSubview(orderImage)
        
        orderImage.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(20)
            make.height.equalTo(orderImage.snp.width)
            make.height.equalTo(self.snp.height).multipliedBy(0.6)
            make.centerY.equalTo(self)
        }
        self.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(8)
            make.left.equalTo(self.orderImage.snp.right).offset(10)
            make.right.equalTo(self).offset(8)
            make.bottom.equalTo(self).offset(8)
        }

        let tapGestureRecognizerToShowOrderImage = UITapGestureRecognizer(target: self, action: #selector(showImageView(tapGestureRecognizer:)))
        orderImage.isUserInteractionEnabled = true
        orderImage.addGestureRecognizer(tapGestureRecognizerToShowOrderImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureCellWith(order:Order,delegate:OrdereCellAction) {
        descriptionLabel.text =  order.descriptionField
        
        guard let path = order.imageUrl  else {
            return
        }
        orderImage.setImageWith(path)
        self.delegate = delegate

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @objc func showImageView(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        // Your action
        delegate.showOrderImage(imageView: tappedImage)
    }
}
