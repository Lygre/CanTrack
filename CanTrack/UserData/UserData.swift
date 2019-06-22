//
//  UserData.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/9/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import Combine
import SwiftUI

//make default products array here
//private let defaultProducts = ProductStore(products: [
//	Product(strain: Strain(name: "Strawberry Switchblade", race: .hybrid, description: nil), productType: .truShatter),
//	Product(strain: Strain(name: "Sour Diesel", race: .sativa, description: nil), productType: .truShatter)
//	])

private let defaultStrains: [Strain] = [
	Strain(name: "Strawberry Switchblade", race: .hybrid, description: "Very awesome energizing hybrid"),
	Strain(name: "Sour Diesel", race: .sativa, description: "Nice tasting Sativa")
]

//final class UserData here
class UserData: BindableObject, Equatable, Hashable, Codable {
	static func == (lhs: UserData, rhs: UserData) -> Bool {
		return lhs.strains == rhs.strains
	}

	let didChange = PassthroughSubject<Void, Never>()

	enum CodingKeys: String, CodingKey {
		case strains
	}

	var strains: [Strain] = [] {
		didSet {
			didChange.send()
		}
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(strains, forKey: .strains)
	}

	required init(from aDecoder: Decoder) {
		do {
			let values = try aDecoder.container(keyedBy: CodingKeys.self)
			strains = try values.decode([Strain].self, forKey: .strains)
		} catch {
			strains = [

			]
			print(error)
		}
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(strains)
	}

	init() {
		self.strains = defaultStrains
	}

}
