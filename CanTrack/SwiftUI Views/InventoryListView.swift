//
//  InventoryListView.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/9/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

let testData = defaultProducts.products

struct InventoryListView : View {
//	@EnvironmentObject var userData: UserData
//	@EnvironmentObject var productStore: ProductStore
	@ObjectBinding var productStore = ProductStore(products: testData)

	var body: some View {
		return VStack {
			List(productStore.products) { product in
				NavigationButton(destination: ProductDetailView(product: product)) { ProductRow(product: product)
				}

			}
		}
	}
}

#if DEBUG
struct InventoryListView_Previews : PreviewProvider {
    static var previews: some View {
        InventoryListView(productStore: ProductStore(products: testData))
    }
}
#endif
