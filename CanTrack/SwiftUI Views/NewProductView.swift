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

	//basically bind this to our product to be created's properties
	@EnvironmentObject var userData: UserData
	@State var testProd: Product = Product(strain: Strain.default, productType: .rosin)


	var body: some View {
		NavigationView {
			List {
				Group {
					Section(header: Text("Type, Strain, and Mass")) {

						HStack {
							Picker(selection: $testProd.productType, label: Text("Product Type")) {
								ForEach(Product.ProductType.allCases.identified(by: \.identifiedValue)) { type in
									Text(type.rawValue).tag(type)
								}
							}
						}

						//Strain Picker cannot be fully implemented right now
//						HStack {
//							Picker(selection: $testProd.strain, label: Text("Product Strain")) {
//								ForEach($userData.strains) { strain in
//									Text(strain.name).tag(strain)
//								}
//
//							}
//						}

						HStack {
							Text("Mass")
							Spacer()
							VStack {
								TextField($testProd.mass, placeholder: Text("Mass"), onEditingChanged: { (editingChangedText) in

								}, onCommit: {

								})
								.textFieldStyle(.roundedBorder)
							}
						}

					}

				}
				}.listStyle(.grouped)
			Text("Placeholder")
			.navigationBarItems(leading: Text("Cancel").color(.red), trailing: Text("Save").color(.blue))
			.navigationBarTitle(Text("Add New Product"), displayMode: .inline)
			}.foregroundColor(Color.green)

//			.navigationBarTitle(Text("Add New Product"))
	}

	private func createProduct() {
		self.userData.products.insert($testProd.value, at: 0)

	}

}

#if DEBUG
struct NewProductView_Previews : PreviewProvider {
    static var previews: some View {
		NewProductView().environmentObject(UserData())
    }
}
#endif
