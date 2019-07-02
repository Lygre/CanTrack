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
import Datez

let testDoseing: Dose = {
	Dose(product: ProductStore.defaultProduct, mass: 1.0, administrationRoute: .inhalation, doseTimestamp: (Date().currentCalendar + 1.day).date)
}()

let testDate: Date = {
	var cmp = DateComponents()
	cmp.calendar = .current
	cmp.calendar?.locale = .current
	cmp.timeZone = .current
	cmp.year = 2019
	cmp.month = 6
	cmp.day = 29
	return cmp.isValidDate ? cmp.date! : Date()
}()
//var testingStore = DoseStore(doses: [testDoseing])


class DoseStore {

	static let shared = DoseStore()

	var doses: [Dose] = [
		Dose(product: defaultProducts.products[0], mass: 0.3, administrationRoute: .inhalation, doseTimestamp: testDate),
		Dose(product: defaultProducts.products[0], mass: 0.3, administrationRoute: .inhalation, doseTimestamp: (testDate.gregorian.date)),
		Dose(product: defaultProducts.products[1], mass: 0.7, administrationRoute: .oral)
	]

	static let defaultDose: Dose = Dose(product: Product.defaultProduct, mass: 0.0, administrationRoute: .inhalation, doseTimestamp: Date())

	private init() { load() }

	func save() {
		UserDefaults.standard.set(try? PropertyListEncoder().encode(doses), forKey: "doseStore")
		debugPrint("save called")
	}

	func load() {
		if let data = UserDefaults.standard.object(forKey: "doseStore") as? Data {
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
