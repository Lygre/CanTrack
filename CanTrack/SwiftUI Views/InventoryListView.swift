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
	@State var testProd: Product = ProductStore.defaultProduct

	var modal: Modal {
		Modal(NewProductView(isPresented: $isModal).environmentObject(UserData()).environmentObject(productStore), onDismiss: {
//			self.isModal.toggle()
		})
	}

	var modalPresentation: some View {
		NavigationView {
			List {
				Group {
					Section(header: Text("Type, Strain, and Mass")) {

						HStack {
							Picker(selection: self.$testProd.productType, label: Text("Product Type")) {
								ForEach(Product.ProductType.allCases.identified(by: \.identifiedValue)) { type in
									Text(type.rawValue).tag(type)
								}
							}
						}
						//Strain Picker cannot be fully implemented right now
						HStack {
							Picker(selection: $testProd.strain, label: Text("Product Strain")) {
								ForEach($userData.strains.value) { strain in
									Text(strain.name).tag(strain)
								}

							}
						}

						HStack {
							Text("Mass")
							Spacer()
							VStack {
								TextField(self.$testProd.mass, placeholder: Text("Mass"), onEditingChanged: { (editingChangedText) in

								}, onCommit: {

								})
									.textFieldStyle(.roundedBorder)
							}
						}

					}

				}
				}.listStyle(.grouped).onDisappear {
					self.createProduct()
				}


				.navigationBarItems(leading: Button(action: {
					self.isModal = false
				}, label: {
					Text("Cancel")
						.color(.red)
				}), trailing: Button(action: {
					self.createProduct()
				}, label: {
					Text("Save")
						.color(.blue)
				}))
				.navigationBarTitle(Text("Add New Product"), displayMode: .inline)
			}.foregroundColor(Color.green)
	}

	var body: some View {
		NavigationView {
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
					ForEach(productStore.products) { product in
						NavigationButton(destination: ProductDetailView(product: product)) { ProductRow(product: product)
							
						}
					}
				}
				}
				.listStyle(.grouped)

		}
			.presentation(isModal ? Modal(modalPresentation, onDismiss: {
				self.isModal.toggle()
			}) : nil)
		}
	}

	func deleteProduct(at offsets: IndexSet) {

		productStore.products.remove(at: offsets.count)
	}

	func addNewProduct() {
//		productStore.products.append($draftNewProduct.value)
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
