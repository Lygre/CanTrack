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
private let defaultProducts: [Product] = [
	Product(strain: Strain(name: "Strawberry Switchblade", race: .hybrid, description: nil), productType: .truShatter),
	Product(strain: Strain(name: "Sour Diesel", race: .sativa, description: nil), productType: .truShatter)
]



var inventory = defaultProducts

//final class UserData here
final class UserData: BindableObject {
	let didChange = PassthroughSubject<UserData, Never>()

	@UserDefaultValue(key: "Inventory", defaultValue: defaultProducts)
	var products: [Product] {
		didSet {
			didChange.send(self)
		}
	}


}
