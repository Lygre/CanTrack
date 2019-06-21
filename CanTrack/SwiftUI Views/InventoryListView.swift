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
	@State var isModal: Bool = false


	var modal: Modal {
		Modal(NewProductView().environmentObject(UserData()).environmentObject(productStore)) {
			self.isModal = false
		}
	}

	var body: some View {
		ZStack(alignment: Alignment.center) {
			List {
				Section {
					Button(action: {
						self.isModal = true
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
						.presentation(isModal ? modal : nil)
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
	}

	func deleteProduct(at offsets: IndexSet) {

		productStore.products.remove(at: offsets.count)
	}

	func addNewProduct() {
//		productStore.products.append($draftNewProduct.value)
	}

	func presentContextMenu(button: NavigationButton<ProductRow, ProductDetailView>) -> some View {

		let stack = ZStack(alignment: Alignment.center, content: {
			button

		})
		return stack
	}

	func makeNewProductPresentationButton() -> some View {
		let newProdView = NewProductView().environmentObject(UserData()).environmentObject(productStore)
		let button = PresentationButton(destination: NewProductView().environmentObject(UserData()).environmentObject(productStore)) {
			VStack(alignment: .leading) {
				HStack {
					Image(systemName: "bag.badge.plus")
						.imageScale(.large)
						.padding()

					Text("Add Product")
				}
			}
		}
		return button
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
