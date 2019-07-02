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

let defaultStrains: [Strain] = [
	Strain(name: "Strawberry Switchblade", race: .hybrid, description: "Very awesome energizing hybrid"),
	Strain(name: "Sour Diesel", race: .sativa, description: "Nice tasting Sativa")
]

class StrainStore {

	static let shared = StrainStore()

	static let defaultStrain: Strain = Strain.default

	private init() {
		load()
	}

	var strains: [Strain] = defaultStrains

	let networkManager = NetworkController()

	var rawStrainInformation: [String: StrainInformation] = [:] {
		didSet {
			for (strainName, strainInformation) in self.rawStrainInformation {
				var strainToAppend = Strain(name: strainName, race: Strain.StrainVariety.init(rawValue: strainInformation.race)!, description: nil)
				strainToAppend.flavors = strainInformation.flavors
				strains.append(strainToAppend)
			}
		}
	}

	func save() {
		UserDefaults.standard.set(try? PropertyListEncoder().encode(strains), forKey: "strainStore")
		debugPrint("strainStore save called")
	}

	func load() {
		if let data = UserDefaults.standard.object(forKey: "strainStore") as? Data {
			self.strains = try! PropertyListDecoder().decode([Strain].self, from: data)
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
