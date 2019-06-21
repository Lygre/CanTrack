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
							/*

							ForEach(productStore.products.identified(by: \.id)) { product in
								ProductImageViewCircular(product: product)
									.scaledToFit()
							}
							*/
							ForEach(Product.ProductType.allCases.identified(by: \.hashValue)) { type in
								HStack {
									Text(type.rawValue)
									Image(systemName: "smoke")
								}
								.padding()

							}
						}

						}.lineLimit(nil).frame(width: 360, height: 90, alignment: .center)
				}
				Section {
					ForEach(productStore.products) { product in
						NavigationButton(destination: ProductDetailView(product: product)) { ProductRow(product: product)
							
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

	func presentContextMenu(button: NavigationButton<ProductRow, ProductDetailView>) -> some View {

		let stack = ZStack(alignment: Alignment.center, content: {
			button

		})
		return stack
	}



	func makeContextMenu() -> UIMenu {
		let dose = UIAction(__title: "Dose with Product", image: UIImage(systemName: "smoke"), options: []) { action in
			//show system share sheet

		}
		return UIMenu(__title: "Dose Menu", image: UIImage(systemName: "smoke"), identifier: nil, children: [dose])
	}



}

#if DEBUG
struct InventoryListView_Previews : PreviewProvider {
    static var previews: some View {
		NavigationView {
			InventoryListView().environmentObject(ProductStore(products: defaultProducts.products)).environmentObject(UserData())
		}
    }
}
#endif
