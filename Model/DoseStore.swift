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


class DoseStore: Equatable, Hashable, Codable, BindableObject {

	/// CodingKeys enum
	enum CodingKeys: String, CodingKey {
		case doses
	}

	let didChange = PassthroughSubject<Void, Never>()

	var doses: [Dose] {
		didSet {
			didChange.send()
		}
	}

	static let defaultDose: Dose = Dose(product: Product.defaultProduct, mass: 0.0, administrationRoute: .inhalation, doseTimestamp: Date())

	init(doses: [Dose]) {
		self.doses = doses
	}


	/// Establishes conformance to Equatable protocol
	/// - Parameter lhs: Comparable item 1
	/// - Parameter rhs: Comparable item 2
	static func == (lhs: DoseStore, rhs: DoseStore) -> Bool {
		return lhs.doses == rhs.doses
	}

	/// Establishes conformance to Hashable
	/// - Parameter hasher: hasher to provide hashValue
	func hash(into hasher: inout Hasher) {
		hasher.combine(doses)
	}

}
