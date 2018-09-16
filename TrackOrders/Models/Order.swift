//
//	Order.swift
//
//	Create by Ahmed Tawfik on 14/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Order : Codable {

	let descriptionField : String?
	let id : Int?
	let imageUrl : String?
	let location : Location?


	enum CodingKeys: String, CodingKey {
		case descriptionField = "description"
		case id = "id"
		case imageUrl = "imageUrl"
		case location
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        location = try values.decodeIfPresent(Location.self, forKey: .location)
	}


}
