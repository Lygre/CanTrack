//
//  ProductStore.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/9/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI
import Combine

let defaultProducts = ProductStore(products: [
	Product(strain: Strain(name: "Strawberry Switchblade", race: .hybrid, description: nil), productType: .truShatter),
	Product(strain: Strain(name: "Sour Diesel", race: .sativa, description: nil), productType: .truFlower)
	])

let defaultProductJustTheProductsArray = defaultProducts.products



class ProductStore {

	static let shared = ProductStore()

	var products: [Product] = [
		Product(strain: Strain(name: "Strawberry Switchblade", race: .hybrid, description: nil), productType: .truShatter),
		Product(strain: Strain(name: "Sour Diesel", race: .sativa, description: nil), productType: .truFlower)
		] {
		didSet {
			self.productTypes = {
				let inventory = self.products
				var categories: Set<Product.ProductType> = []
				for product in inventory {
					categories.insert(product.productType)
				}
				return Array(categories).sorted(by: { $0.rawValue < $1.rawValue })
			}()
		}
	}


	var showFavoriteProductsOnly = false {
		didSet {
			didChange.send()
		}
	}

	var productTypes: [Product.ProductType] = []

	static let defaultProduct = Product(strain: Strain.default, productType: .rosin)

	private init() { load() }

	func save() {
		UserDefaults.standard.set(try? PropertyListEncoder().encode(products), forKey: "productStore")
		debugPrint("productStore save called")
	}

	func load() {
		if let data = UserDefaults.standard.object(forKey: "productStore") as? Data {
			self.products = try! PropertyListDecoder().decode([Product].self, from: data)
		}
	}


}
