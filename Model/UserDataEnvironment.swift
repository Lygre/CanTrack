//
//  UserDataEnvironment.swift
//  CanTrack
//
//  Created by Hugh Broome on 7/2/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: BindableObject {
	let didChange = PassthroughSubject<UserData, Never>()

	var doses: [Dose] = DoseStore.shared.doses {
		didSet {
			didChange.send(self)
			DoseStore.shared.doses = doses
		}
	}

	var products: [Product] = ProductStore.shared.products {
		didSet {
			didChange.send(self)
			ProductStore.shared.products = products
		}
	}

	var productTypes: [Product.ProductType] = ProductStore.shared.productTypes {
		didSet {
			didChange.send(self)
			ProductStore.shared.productTypes = productTypes
		}
	}

	var showFavoriteProductsOnly: Bool = ProductStore.shared.showFavoriteProductsOnly {
		didSet {
			didChange.send(self)
			ProductStore.shared.showFavoriteProductsOnly = showFavoriteProductsOnly
		}
	}

	var strains: [Strain] = StrainStore.shared.strains {
		didSet {
			didChange.send(self)
			StrainStore.shared.strains = strains
		}
	}

}
