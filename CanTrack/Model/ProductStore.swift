//
//  ProductStore.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/9/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI
import Combine
import SwifterSwift

let defaultProducts = ProductStore(products: [
	Product(strain: Strain(name: "Strawberry Switchblade", race: .hybrid, description: nil), productType: .truShatter),
	Product(strain: Strain(name: "Sour Diesel", race: .sativa, description: nil), productType: .truShatter)
	])



class ProductStore: Equatable, Hashable, Codable, BindableObject {

	let didChange = PassthroughSubject<ProductStore, Never>()

//	@UserDefaultValue(key: "ProductStore", defaultValue: )
	var products: [Product] {
		didSet {
			didChange.send(self)
		}
	}

	enum CodingKeys: String, CodingKey {
		case products
	}

	init(products: [Product]) {
		self.products = products
	}


	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(products, forKey: .products)
	}

	required init(from aDecoder: Decoder) {
		do {
		let values = try aDecoder.container(keyedBy: CodingKeys.self)
		products = try values.decode([Product].self, forKey: .products)
		} catch {
			products = [

			]
			print(error)
		}
	}

	static func == (lhs: ProductStore, rhs: ProductStore) -> Bool {
		return lhs.products == rhs.products
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(products)

	}




}
