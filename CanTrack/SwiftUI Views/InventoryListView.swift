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
//	@ObjectBinding var productStore = ProductStore(products: testData)
	@EnvironmentObject var productStore: ProductStore

	@State var newProduct: Product = Product.defaultProduct
	@State var draftNewProduct: Product = Product.defaultProduct

	var body: some View {
			List {
				Section {
					if $newProduct.value == $draftNewProduct.value {
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
							destination: NewProductView(testProd: $newProduct).environmentObject(UserData()).environmentObject(productStore).onDisappear(perform: {
								self.draftNewProduct = Product.defaultProduct
							}
//								addNewProduct
//								self.draftNewProduct = self.$newProduct.value
								), onTrigger: {
//								self.addNewProduct()
						})

					} else {
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
							destination: NewProductView(testProd: $draftNewProduct).environmentObject(UserData()).environmentObject(productStore).onDisappear(perform: {
								self.draftNewProduct = Product.defaultProduct
							}
								//								addNewProduct
								//								self.draftNewProduct = self.$newProduct.value
							), onTrigger: {

						})
					}

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
		productStore.products.append(draftNewProduct)
	}

	func makeNewProductPresentationButton(to newProduct: Product) -> some View {
		let newProdView = NewProductView(testProd: $draftNewProduct)
		let button = PresentationButton(Button(action: { }) {
			VStack(alignment: .leading) {
				HStack {
					Image(systemName: "bag.badge.plus")
						.imageScale(.large)
						.padding()

					Text("Add Product")
				}
			}
		}, destination: newProdView)
		return button
	}
}

#if DEBUG
struct InventoryListView_Previews : PreviewProvider {
    static var previews: some View {
        InventoryListView().environmentObject(ProductStore(products: defaultProducts.products))
    }
}
#endif
