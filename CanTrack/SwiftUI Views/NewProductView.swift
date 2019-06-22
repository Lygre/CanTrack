//
//  NewProductView.swift
//  CannTrack
//
//  Created by Hugh Broome on 6/6/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI
import Combine


struct NewProductView : View {
	@EnvironmentObject var userData: UserData
	@EnvironmentObject var productStore: ProductStore

	@State var testProd: Product = ProductStore.defaultProduct

	@Binding var draftProduct: Product

	@Binding var isPresented: Bool

	var body: some View {
		NavigationView {
			List {
				Group {
					Section(header: Text("Type, Strain, and Mass")) {

						HStack {
							Picker(selection: self.$draftProduct.productType, label: Text("Product Type")) {
								ForEach(Product.ProductType.allCases.identified(by: \.identifiedValue)) { type in
									Text(type.rawValue).tag(type)
								}
							}
						}

						//Strain Picker cannot be fully implemented right now
						HStack {
							Picker(selection: $draftProduct.strain, label: Text("Product Strain")) {
								ForEach($userData.strains.value) { strain in
									Text(strain.name).tag(strain)
								}

							}
						}

						HStack {
							Text("Mass")
							Spacer()
							VStack {
								TextField(self.$draftProduct.mass, placeholder: Text("Mass"), onEditingChanged: { (editingChangedText) in

								}, onCommit: {

								})
								.textFieldStyle(.roundedBorder)
							}
						}

					}

				}
				}.listStyle(.grouped)


				.navigationBarItems(leading: Button(action: { self.isPresented.toggle() }, label: { Text("Cancel").color(.red)}), trailing: Button(action: addNewProductToStore, label: {
					Text("Save")
						.color(.blue)
				}))
				.navigationBarTitle(Text("Add New Product"), displayMode: .inline)
			}.foregroundColor(Color.green)
			.onDisappear {
				self.draftProduct = ProductStore.defaultProduct
		}
	}

	func addNewProductToStore() {
		self.createProduct()
		self.draftProduct = ProductStore.defaultProduct
		self.isPresented.toggle()
	}

	func createProduct() {
//		draftProduct = $testProd.value
		productStore.products.append($draftProduct.value)
//		defaultProducts.products.insert(self.$testProd.value, at: 0)
//		ProductStore().products.insert(self.$testProd.value, at: 0)

	}

}

#if DEBUG
struct NewProductView_Previews : PreviewProvider {
    static var previews: some View {
		NewProductView(draftProduct: .constant(.defaultProduct), isPresented: .constant(true)).environmentObject(UserData()).environmentObject(ProductStore(products: defaultProducts.products))
    }
}
#endif
