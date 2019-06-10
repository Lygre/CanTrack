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
final class UserData: BindableObject {
	let didChange = PassthroughSubject<UserData, Never>()

//	@UserDefaultValue(key: "Inventory", defaultValue: defaultProducts)
//	var products: ProductStore {
//		didSet {
//			didChange.send(self)
//		}
//	}

	@UserDefaultValue(key: "DefaultProduct", defaultValue: Product.defaultProduct)
	var defaultProduct: Product {
		willSet {
			didChange.send(self)
		}
	}

	@UserDefaultValue(key: "Strains", defaultValue: defaultStrains)
	var strains: [Strain] {
		didSet {
			didChange.send(self)
		}
	}


}
