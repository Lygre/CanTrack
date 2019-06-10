//
//  InventoryListView.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/9/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI
import Combine
let testData = defaultProducts.products


struct InventoryListView : View {
//	@EnvironmentObject var userData: UserData
//	@EnvironmentObject var productStore: ProductStore
	@ObjectBinding var productStore = ProductStore(products: testData)
	@ObjectBinding var newProduct: Product = Product(strain: Strain.default, productType: .rosin)
	
	var body: some View {
			List {
				Section {
					PresentationButton(
						Button(action: { }) {
							VStack(alignment: .leading) {
								HStack {
									Image(systemName: "bag.badge.plus")
										.imageScale(.large)
										.padding()

									Text("Add Product")
								}
							}
						},
						destination: NewProductView(testProd: newProduct), onTrigger: {
							self.addNewProduct()
					})

				}
				Section {
					ForEach(productStore.products) { product in
						NavigationButton(destination: ProductDetailView(product: product)) { ProductRow(product: product)
						}
					}
//					.onDelete(perform: deleteProduct())
				}
				}.listStyle(.grouped)

	}

	func deleteProduct(at offsets: IndexSet) {

		productStore.products.remove(at: offsets.count)
	}

	func addNewProduct() {
		productStore.products.append(newProduct)
	}
}

#if DEBUG
struct InventoryListView_Previews : PreviewProvider {
    static var previews: some View {
        InventoryListView(productStore: ProductStore(products: testData))
    }
}
#endif
