//
//	Location.swift
//
//	Create by Ahmed Tawfik on 14/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Location : Codable {

	let address : String?
	let lat : Float?
	let lng : Float?


	enum CodingKeys: String, CodingKey {
		case address = "address"
		case lat = "lat"
		case lng = "lng"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		lat = try values.decodeIfPresent(Float.self, forKey: .lat)
		lng = try values.decodeIfPresent(Float.self, forKey: .lng)
	}


}