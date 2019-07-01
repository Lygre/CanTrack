//
//  Dose.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/22/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import Foundation
import Combine
import SwiftUI


/// Dose Model Object
///
struct Dose: Equatable, Hashable, Codable, Identifiable {
	let id: UUID
	let timestamp: Date
	let product: Product
	var mass: Double = 0.0
	var administrationRoute: AdministrationRoute = .inhalation
	var doseImage: UIImage? = UIImage(named: "cannabisbg")
	var viewBuilderImage: Image = Image(systemName: "smoke.fill")

	init(product: Product, mass: Double, administrationRoute: AdministrationRoute) {
		self.id = UUID()
		self.timestamp = Date()
		self.product = product
		self.mass = mass
		self.administrationRoute = administrationRoute
	}

	init(product: Product, mass: Double, administrationRoute: AdministrationRoute?, doseTimestamp: Date?) {
		self.id = UUID()
		self.timestamp = doseTimestamp ?? Date()
		self.product = product
		self.mass = mass
		self.administrationRoute = administrationRoute ?? .inhalation
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(timestamp, forKey: .timestamp)
		try container.encode(product, forKey: .product)
		try container.encode(mass, forKey: .mass)
		try container.encode(administrationRoute, forKey: .administrationRoute)

		let img = doseImage
		let manager = FileManager.default
		let dir = manager.urls(for: .documentDirectory, in: .userDomainMask)
		let file = dir[0].appendingPathComponent((timestamp.description(with: .current)) + product.productType.rawValue + self.product.strain.name)
		try img?.jpegData(compressionQuality: 0.5)?.write(to: file, options: .atomic)
		let imgURL = NSURL.fileURL(withPath: file.path)

		try container.encode(imgURL, forKey: .doseImage)
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decode(UUID.self, forKey: .id)
		timestamp = try values.decode(Date.self, forKey: .timestamp)
		product = try values.decode(Product.self, forKey: .product)
		mass = try values.decode(Double.self, forKey: .mass)
		administrationRoute = try values.decode(AdministrationRoute.self, forKey: .administrationRoute)

		let imgURL = try values.decode(URL.self, forKey: .doseImage)
		let imgPath = imgURL.path

		doseImage = UIImage(contentsOfFile: imgPath)
	}

	enum AdministrationRoute: String, Hashable, Codable, CaseIterable {
		case oral = "Oral"
		case inhalation = "Inhalation"
	}

	enum CodingKeys: String, CodingKey {
		case id
		case timestamp
		case product
		case mass
		case administrationRoute
		case otherProducts
		case doseImage
	}

	static func == (lhs: Dose, rhs: Dose) -> Bool {
		return lhs.timestamp == rhs.timestamp && lhs.product == rhs.product && lhs.mass == rhs.mass
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(timestamp)
		hasher.combine(product)
	}
}
