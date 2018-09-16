//
//  OrderDetailsViewController.swift
//  TrackOrders
//
//  Created by BinaryBoy on 9/15/18.
//  Copyright (c) 2018 BinaryBoy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MapKit
import SnapKit

class OrderDetailsViewController: BaseViewController {
    fileprivate let viewModel: OrderDetailsViewModel
    fileprivate let router: OrderDetailsRouter
    fileprivate let disposeBag = DisposeBag()
    
    
    private var orderImage: UIImageView!
    private var descriptionLabel: UILabel!
    private var  mapView:MKMapView!
    
    init(withViewModel viewModel: OrderDetailsViewModel, router: OrderDetailsRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupLayout()
        setupRx()
    }
}

// MARK: Setup
private extension OrderDetailsViewController {
    
    func setupViews() {
        self.title = viewModel.order.location?.address
        mapView = MKMapView()
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        view.addSubview(mapView)

        mapView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(0)
            make.left.equalTo(self.view).offset(0)
            make.right.equalTo(self.view).offset(0)
            make.height.equalToSuperview().multipliedBy(0.7)

        }
        view.backgroundColor = .white
        
        orderImage = UIImageView(image: #imageLiteral(resourceName: "lalamove"))
        if let path = viewModel.order.imageUrl {
            orderImage.setImageWith(path)
        }
        view.addSubview(orderImage)
        orderImage.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.height.equalTo(orderImage.snp.width)
            make.height.equalTo(100)

        }
        
        descriptionLabel = UILabel()
        descriptionLabel.text = viewModel.order.descriptionField
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.right.equalTo(view).offset(20)
            make.left.equalTo(orderImage.snp.right).offset(20)
        }
        
        guard let lat = viewModel.order.location?.lat ,let lng = viewModel.order.location?.lng else {
            return
        }
        let loc = MKPointAnnotation()
        loc.coordinate = CLLocationCoordinate2D(latitude:CLLocationDegrees(lat) ,
                                                longitude: CLLocationDegrees(lng));
        // show annotations
        mapView.addAnnotation(loc)
        mapView.showAnnotations([loc], animated: true)
                
    }
    
    func setupLayout() {
        
    }
    
    func setupRx() {
        
    }
}
extension OrderDetailsViewController : MKMapViewDelegate {
}
