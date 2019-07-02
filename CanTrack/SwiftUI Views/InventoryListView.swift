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
	@EnvironmentObject var userData: UserData

	@State private var isModal: Bool = false

	@State private var activeFilterType: Product.ProductType = nil
	@State private var isFiltered: Bool = false

	@State private var testProd: Product = {
		return ProductStore.defaultProduct
	}()
	private var draftNewProd: Product = ProductStore.defaultProduct

	var modal: Modal {
		Modal(NewProductView(draftProduct: $testProd, isPresented: $isModal).environmentObject(userData), onDismiss: {
			self.isModal.toggle()
		})
	}

	#if !os(tvOS)
	var body: some View {
		NavigationView {
			List {
				Section {
					Button(action: {
						self.isModal.toggle()
					}, label: {
						VStack(alignment: .leading) {
							HStack {
								Image(systemName: "waveform.path.badge.plus")
									.imageScale(.large)
									.padding()
								Text("Add Product")
							}
						}
						})
				}
				Section(header:
					Button(action: {
						self.isFiltered = false
						self.activeFilterType = nil
					}) {

							$activeFilterType.value == nil ?
								nil :
								HStack {
									Spacer()
								Text("Clear")
									.font(.headline)
								Image(systemName: "xmark.circle.fill").imageScale(.large)
						}
					}
				) {
					ScrollView(alwaysBounceHorizontal: true, alwaysBounceVertical: false,  showsHorizontalIndicator: false) {
						HStack(alignment: .center) {

							ForEach(userData.productTypes.identified(by: \.identifiedValue)) { type in
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
										.clipShape(RoundedRectangle(cornerRadius: 8), style: FillStyle.init(eoFill: false, antialiased: false))
										.border(Color.black, cornerRadius: 8)
								}
							}
							Spacer()
						}

						}.lineLimit(nil).frame(height: 55)
				}
				Section {
					!isFiltered ?
						ForEach(userData.products.identified(by: \.identifiedValue)) { product in
							NavigationButton(destination: ProductDetailView(product: product)) {
								ProductRow(product: product)
							}
						}
						:
						ForEach(userData.products.compactMap({ (someProduct) -> Product? in
							return (someProduct.productType == activeFilterType!) ? someProduct : nil
						}).identified(by: \.identifiedValue)) { product in
							NavigationButton(destination: ProductDetailView(product: product)) {
								ProductRow(product: product)
							}
						}
				}
				}
				.listStyle(.grouped)
				.navigationBarTitle(Text("Inventory"))

			}
			.presentation(isModal ? modal : nil)

	}
	#elseif os(tvOS)
	var body: some View {
			List {
				Section {
					Button(action: {
						self.isModal.toggle()
					}, label: {
						VStack(alignment: .leading) {
							HStack {
								Image(systemName: "waveform.path.badge.plus")
									.imageScale(.large)
									.padding()
								Text("Add Product")
							}
						}
					})
				}
				Section(header:
					Button(action: {
						self.isFiltered = false
						self.activeFilterType = nil
					}) {

						$activeFilterType.value == nil ?
							nil :
							HStack {
								Text("Clear")
									.font(.headline)
								Image(systemName: "xmark.circle.fill").imageScale(.large)
						}
						.padding()
					}
				) {
					ScrollView(alwaysBounceHorizontal: true, alwaysBounceVertical: false,  showsHorizontalIndicator: false) {
						HStack(alignment: .center) {

							ForEach(ProductStore.shared.productTypes.identified(by: \.hashValue)) { type in
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
										.clipShape(RoundedRectangle(cornerRadius: 8), style: FillStyle.init(eoFill: false, antialiased: false))
										.border(Color.black, cornerRadius: 8)
								}
							}
							Spacer()
						}

						}.lineLimit(nil).frame(height: 55)
				}
				Section {
					!isFiltered ?
						ForEach(userData.products.identified(by: \.identifiedValue)) { product in
							NavigationButton(destination: ProductDetailView(product: product)) {
								ProductRow(product: product)
							}
						}
						:
						ForEach(userData.products.compactMap({ (someProduct) -> Product? in
							return (someProduct.productType == activeFilterType!) ? someProduct : nil
						}).identified(by: \.identifiedValue)) { product in
							NavigationButton(destination: ProductDetailView(product: product)) {
								ProductRow(product: product)
							}
					}
				}
				}
				.listStyle(.grouped)
				.navigationBarTitle(Text("Inventory"))


			.presentation(isModal ? modal : nil)

	}
	#endif

	func deleteProduct(at offsets: IndexSet) {

		userData.products.remove(at: offsets.count)
	}

	func createProduct() {
		userData.products.append($testProd.value)
	}





}

#if DEBUG

//let store = ProductStore(products: testData)

struct InventoryListView_Previews : PreviewProvider {
	static var previews: some View {
		InventoryListView().environmentObject(UserData())
	}
}
#endif
