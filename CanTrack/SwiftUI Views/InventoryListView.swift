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
	@State var focusedContext: Bool = false
	@State var focusedProduct: Product = nil

	var body: some View {
		ZStack(alignment: Alignment.center) {
			List {
				Section {
					self.makeNewProductPresentationButton()
				}
				Section {
					ForEach(productStore.products) { product in
						NavigationButton(destination: ProductDetailView(product: product)) { ProductRow(product: product)
							
							}.longPressAction({
								self.focusedProduct = product
								self.focusedContext.toggle()
							})
					}

					}

				}
				.listStyle(.grouped)
				.tapAction {
					if self.$focusedContext.value == true { self.focusedContext.toggle() }
				}.blur(radius: Length(integerLiteral: focusedContext ? 4 : 0))
			focusedContext ?
				VStack(alignment: .leading) {
					ProductRow(product: $focusedProduct.value!)
					.frame(minWidth: 180, idealWidth: 220, maxWidth: 230, minHeight: 100, idealHeight: 200, maxHeight: 300, alignment: Alignment.bottomLeading)
					ContextMenu()
					.frame(minWidth: 180, idealWidth: 220, maxWidth: 230, minHeight: 100, idealHeight: 200, maxHeight: 300, alignment: Alignment.bottomLeading)
				}
				.padding()
				: nil
		}
	}

	func deleteProduct(at offsets: IndexSet) {

		productStore.products.remove(at: offsets.count)
	}

	func addNewProduct() {
//		productStore.products.append($draftNewProduct.value)
	}

	func presentContextMenu(button: NavigationButton<ProductRow, ProductDetailView>) -> some View {

		let stack = ZStack(alignment: .center, content: {
			button
			ContextMenu()
		})
		return stack
	}

	func makeNewProductPresentationButton() -> some View {
		let newProdView = NewProductView().environmentObject(UserData()).environmentObject(productStore)
		let button = PresentationButton(
			VStack(alignment: .leading) {
				HStack {
					Image(systemName: "bag.badge.plus")
						.imageScale(.large)
						.padding()

					Text("Add Product")
				}

		}, destination: newProdView)
		return button
	}

	func makeContextMenu() -> UIMenu<UIAction> {
		let dose = UIAction(__title: "Dose with Product", image: UIImage(systemName: "smoke"), options: []) { action in
			//show system share sheet

		}
		return UIMenu<UIAction>.create(title: "Dose", children: [dose])
	}



}

#if DEBUG
struct InventoryListView_Previews : PreviewProvider {
    static var previews: some View {
        InventoryListView().environmentObject(ProductStore(products: defaultProducts.products))
    }
}
#endif
