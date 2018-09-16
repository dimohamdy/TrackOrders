//
//	Order.swift
//
//	Create by Ahmed Tawfik on 14/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import RealmSwift

class Order : Object,Codable {

	@objc dynamic var descriptionField : String? = nil
	@objc dynamic var id : Int = 0
	@objc dynamic var imageUrl : String? = nil
	@objc dynamic var location : Location? = nil


	enum CodingKeys: String, CodingKey {
		case descriptionField = "description"
		case id = "id"
		case imageUrl = "imageUrl"
		case location
	}
    convenience required init(from decoder: Decoder) throws  {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
		descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
		id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
		imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        location = try values.decodeIfPresent(Location.self, forKey: .location)
	}
    

    override static func primaryKey() -> String? {
        return "id"
    }

    public static func ==(lhs: Order, rhs: Order) -> Bool {
        return lhs.id == rhs.id
    }
}
