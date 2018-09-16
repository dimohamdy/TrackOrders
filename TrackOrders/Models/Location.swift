//
//	Location.swift
//
//	Create by Ahmed Tawfik on 14/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import RealmSwift

class Location : Object,Codable {

	@objc dynamic var address : String? = nil
	@objc dynamic var lat : Float = 0.0
	@objc dynamic var lng : Float = 0.0


	enum CodingKeys: String, CodingKey {
		case address = "address"
		case lat = "lat"
		case lng = "lng"
	}
    convenience required init(from decoder: Decoder) throws  {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		lat = try values.decodeIfPresent(Float.self, forKey: .lat) ?? 0.0
		lng = try values.decodeIfPresent(Float.self, forKey: .lng) ?? 0.0
	}
    

}
