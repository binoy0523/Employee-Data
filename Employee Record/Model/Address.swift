//
//  Address.swift
//  Employee Record
//
//  Created by user on 20/06/20.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation
struct AddressData : Codable {
	let street : String?
	let suite : String?
	let city : String?
	let zipcode : String?
	let geo : Geo?

	enum CodingKeys: String, CodingKey {

		case street = "street"
		case suite = "suite"
		case city = "city"
		case zipcode = "zipcode"
		case geo = "geo"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		street = try values.decodeIfPresent(String.self, forKey: .street)
		suite = try values.decodeIfPresent(String.self, forKey: .suite)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		zipcode = try values.decodeIfPresent(String.self, forKey: .zipcode)
		geo = try values.decodeIfPresent(Geo.self, forKey: .geo)
	}

}
