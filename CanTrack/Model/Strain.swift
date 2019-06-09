//
//  Strain.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/9/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

struct Strain: Hashable, Equatable, Identifiable, Codable {
	let id: UUID
	let name: String
	let race: StrainVariety
	let desc: String?
	var favorite: Bool
	var effects: Effects?
	var flavors: [String]?

	static let `default` = Strain(name: "Default Strain", race: .hybrid, description: nil)

	init(name: String, race: StrainVariety, description: String?) {
		self.id = UUID()
		self.name = name
		self.race = race
		self.desc = description
		self.favorite = false
		self.effects = nil


	}

	enum StrainVariety: String, Codable, Equatable, Hashable {
		case hybrid = "hybrid"
		case indica = "indica"
		case sativa = "sativa"
	}

	struct Effects: Encodable, Decodable, Hashable, Equatable {
		var positive: [String]?
		var negative: [String]?
		var medical: [String]?
	}

	static func == (lhs: Strain, rhs: Strain) -> Bool {
		return lhs.id == rhs.id && lhs.name == rhs.name && lhs.race == rhs.race
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
		hasher.combine(name)
		hasher.combine(race)

	}
}

