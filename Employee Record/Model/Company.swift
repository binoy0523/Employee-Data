//
//  Company.swift
//  Employee Record
//
//  Created by user on 20/06/20.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation
struct CompanyData : Codable {
	let name : String?
	let catchPhrase : String?
	let bs : String?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case catchPhrase = "catchPhrase"
		case bs = "bs"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		catchPhrase = try values.decodeIfPresent(String.self, forKey: .catchPhrase)
		bs = try values.decodeIfPresent(String.self, forKey: .bs)
	}

}
