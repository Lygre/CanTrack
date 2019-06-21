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
	@EnvironmentObject var productStore: ProductStore
	@EnvironmentObject var userData: UserData
	@State var isModal: Bool = false
	@State var testProd: Product = {
		return ProductStore.defaultProduct
	}()

	@State var activeFilterType: Product.ProductType = nil
	@State var isFiltered: Bool = false

	private var draftNewProd: Product = ProductStore.defaultProduct

	var modal: Modal {
		Modal(NewProductView(draftProduct: $testProd, isPresented: $isModal).environmentObject(UserData()).environmentObject(productStore), onDismiss: {
			self.isModal.toggle()
			self.createProduct()
			self.testProd = self.draftNewProd
		})

	}


	var body: some View {
		ZStack(alignment: Alignment.center) {
			List {
				Section {
					Button(action: {
						self.isModal.toggle()
					}, label: {
						VStack(alignment: .leading) {
							HStack {
								Image(systemName: "bag.badge.plus")
									.imageScale(.large)
									.padding()
								Text("Add Product")
							}
						}
						})
				}
				Section {
					ScrollView(alwaysBounceHorizontal: true, alwaysBounceVertical: false,  showsHorizontalIndicator: true) {
						HStack(alignment: .center) {
							Button(action: {
								self.isFiltered = false
								self.activeFilterType = nil
							}) {
								HStack {
									Text("None")
									Image(systemName: "smoke")
									}
									.padding()
									.background(Color.green)
									.clipShape(RoundedRectangle(cornerRadius: 8), style: FillStyle.init(eoFill: true, antialiased: false))
									.border(Color.black, cornerRadius: 8)
							}
							ForEach(productStore.productTypes.identified(by: \.hashValue)) { type in
								Button(action: {
									self.activeFilterType = type
									self.isFiltered = true
								}) {
									HStack {
										Text(type.rawValue)
										Image(systemName: "smoke")
										}
										.padding()
										.background(Color.green)
										.clipShape(RoundedRectangle(cornerRadius: 8), style: FillStyle.init(eoFill: true, antialiased: false))
										.border(Color.black, cornerRadius: 8)
								}
							}
						}

						}.lineLimit(nil).frame(width: 360, height: 55, alignment: .center)
				}
				Section {
					if !isFiltered {
						ForEach(productStore.products) { product in
							NavigationButton(destination: ProductDetailView(product: product)) { ProductRow(product: product)

							}
						}
					} else {
						ForEach(productStore.products.compactMap({ (someProduct) -> Product? in
							return (someProduct.productType == activeFilterType!) ? someProduct : nil
						})) { product in
							NavigationButton(destination: ProductDetailView(product: product)) { ProductRow(product: product)

							}
						}
					}
				}
				}
				.listStyle(.grouped)

			}
			.presentation(isModal ? modal : nil)

	}

	func deleteProduct(at offsets: IndexSet) {

		productStore.products.remove(at: offsets.count)
	}

	func createProduct() {
		productStore.products.append($testProd.value)
	}





}

#if DEBUG
struct InventoryListView_Previews : PreviewProvider {
	static var previews: some View {
		NavigationView {
			InventoryListView().environmentObject(defaultProducts).environmentObject(UserData())
		}
	}
}
#endif
