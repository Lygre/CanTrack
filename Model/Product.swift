//
//  Product.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/9/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI
import Combine

/// Product Model object Struct
struct Product: Equatable, Hashable, Codable, Identifiable {

	struct ProductActions: Codable, Hashable {
		var elevation: Range<Double>
		var pace: Range<Double>
		var heartRate: Range<Double>

		
	}

	/// ProductType. Raw type string
	enum ProductType: String, Equatable, Hashable, Identifiable, Codable, CaseIterable {
		var id: ObjectIdentifier {
			return ObjectIdentifier(ProductType.self)
		}
		case truFlower = "truFlower"
		case truCrmbl = "truCRMBL"
		case truClear = "truClear"
		case truPod = "truPod"
		case rosin = "Rosin"
		case truShatter = "truShatter"
		case vapePenCartridge = "Vape Pen Cartridge"
		case co2VapePenCartridge = "CO2 Vape Pen Cartridge"
		case oralSyringe = "Oral Syringe"
		case tinctureDropletBottle = "Tincture Droplet Bottle"
		case capsuleBottle = "Capsule Bottle"
		case topicalSunscreen = "Topical Sunscreen"
		case topicalLotion = "Topical Lotion"
		case rsoSyringe = "RSO Syringe"
		case topicalCream = "Topical Cream"
		case nasalSpray = "Nasal Spray"
	}

	/// CodingKeys for class: to conform to Codable
	enum CodingKeys: String, CodingKey {
		case id
		case productType
		case strain
		case productLabelImage
		case currentProductImage
		case mass
		case dateOpened
		case dosesCount
		case isFavorite
	}
	//MARK: -- Properties/Constants
	let id: UUID

	var productType: ProductType {
		didSet {
			didChange.send(self)
		}
	}

	var strain: Strain {
		didSet {
			didChange.send(self)
		}
	}

	var productImage: UIImage = UIImage(imageLiteralResourceName: "cannabisbg") {
		didSet {
			didChange.send(self)
		}
	}

	var imageIdentifier: String = "cannabisbg"

	var mass: String = "0.0" {
		didSet {
			didChange.send(self)
		}
	}

	var dateOpened: Date? {
		didSet {
			didChange.send(self)
		}
	}

	var dosesCount: Int = 0 {
		didSet {
			didChange.send(self)
		}
	}

	var isFavorite: Bool = false {
		didSet {
			didChange.send(self)
		}
	}

	var didChange = PassthroughSubject<Product, Never>()

	static let defaultProduct: Product = Product(strain: Strain.default, productType: .truFlower)

	func hash(into hasher: inout Hasher) {
		hasher.combine(productType)
		hasher.combine(strain)
		hasher.combine(dateOpened)
	}

	static func == (lhs: Product, rhs: Product) -> Bool {
		return lhs.dateOpened == rhs.dateOpened && lhs.strain == rhs.strain && lhs.productType == rhs.productType
	}




	/// Encodes for Codable conformance
	/// - Parameter encoder: Encoder keyed by our CodingKeys
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(productType, forKey: .productType)
		try container.encode(strain, forKey: .strain)

		try container.encode(mass, forKey: .mass)
		try container.encode(dateOpened, forKey: .dateOpened)
		try container.encode(dosesCount, forKey: .dosesCount)
	}

	init(strain: Strain, productType: ProductType) {
		self.id = UUID()
		self.strain = strain
		self.productType = productType
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decode(UUID.self, forKey: .id)
		productType = try values.decode(ProductType.self, forKey: .productType)
		strain = try values.decode(Strain.self, forKey: .strain)
		mass = try values.decode(String.self, forKey: .mass)
		dateOpened = try? values.decode(Date.self, forKey: .dateOpened)
		dosesCount = try values.decode(Int.self, forKey: .dosesCount)
	}

	/// Returns an image from the ImageStore class
	/// which returns it from the main bundle in turn, using the specified size
	/// - Parameter size: Integer specifying the size desired for the image to be returned
	func image(forSize size: Int) -> Image {
		ImageStore.shared.image(name: imageIdentifier, size: size)
	}


}
