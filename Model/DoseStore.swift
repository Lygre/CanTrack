//
//  DoseStore.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/29/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI
import Combine
import Foundation


class DoseStore {

	/// CodingKeys enum
	enum CodingKeys: String, CodingKey {
		case doses
	}

	var doses: [Dose] = []


	// MARK: - Instance variables
	static let shared = DoseStore()

	static let defaultDose: Dose = Dose(product: Product.defaultProduct, mass: 0.0, administrationRoute: .inhalation, doseTimestamp: Date())


	// MARK: - Initializers
	private init() { load() }


	// MARK: - Methods
	func save() {
		UserDefaults.standard.set(try? PropertyListEncoder().encode(doses), forKey: "doses")
	}

	func load() {
		if let data = UserDefaults.standard.object(forKey: "doses") as? Data {
			self.doses = try! PropertyListDecoder().decode([Dose].self, from: data)
		}
	}

	func getDosePrior(to dose: Dose) -> Dose? {
		guard let indexOfReferenceDose = doses.lastIndex(of: dose) else { return nil }
		if indexOfReferenceDose != 0 {
			return doses[indexOfReferenceDose.advanced(by: -1)]
		}
		return nil

	}


}
