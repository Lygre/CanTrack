//
//  StrainStore.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/22/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class StrainStore: Equatable, Hashable, Codable, BindableObject {

	static func == (lhs: StrainStore, rhs: StrainStore) -> Bool {
		return lhs.strains == rhs.strains
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(strains)
	}

	enum CodingKeys: String, CodingKey {
		case strains
	}

	static let defaultStrain: Strain = Strain.default

	let didChange = PassthroughSubject<Void, Never>()

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(strains, forKey: .strains)
	}

	required init(from aDecoder: Decoder) {
		do {
			let values = try aDecoder.container(keyedBy: CodingKeys.self)
			strains = try values.decode([Strain].self, forKey: .strains)
		} catch {
			strains = []
			print(error)
		}
	}

	init(strains: [Strain]) {
		self.strains = strains
		self.loadStrains()
	}

	var strains: [Strain] {
		didSet {
			didChange.send()
		}
	}

	let networkManager = NetworkController()

	var rawStrainInformation: [String: StrainInformation] = [:] {
		willSet {
			for (strainName, strainInformation) in newValue {
				var strainToAppend = Strain(name: strainName, race: Strain.StrainVariety.init(rawValue: strainInformation.race)!, description: nil)
				strainToAppend.flavors = strainInformation.flavors
				strains.append(strainToAppend)
			}
		}
	}

	func loadStrains() {
		networkManager.getNewStrains { (allStrainsDict, error) in
			if let error = error {
				print(error)
			}
			if let strainsDict = allStrainsDict {
				DispatchQueue.main.async {
					print(strainsDict)
					self.rawStrainInformation = strainsDict
				}
			}
		}
	}

}
