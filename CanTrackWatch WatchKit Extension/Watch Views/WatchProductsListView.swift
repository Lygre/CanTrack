//
//  WatchProductsListView.swift
//  CanTrackWatch WatchKit Extension
//
//  Created by Hugh Broome on 6/28/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

struct WatchProductsListView : View {
	@EnvironmentObject var productStore: ProductStore
	@EnvironmentObject var strainStore: StrainStore



	var body: some View {
		List {
			Toggle(isOn: $productStore.showFavoriteProductsOnly) {
				Text("Favorites Only")
			}
			ForEach(productStore.products.identified(by: \.id)) { product in
				if !self.productStore.showFavoriteProductsOnly || product.isFavorite {
					NavigationButton(destination:
						WatchProductDetail(product: product)
							.environmentObject(self.productStore)
							.environmentObject(self.strainStore)
					) {
						VStack(alignment: .leading) {
							WatchProductRow(product: product)
						}
					}
				}
				}
				.navigationBarTitle(Text("Inventory"))
				.listStyle(.carousel)

		}
	}
}

#if DEBUG
struct WatchProductsListView_Previews : PreviewProvider {
    static var previews: some View {
        WatchProductsListView().environmentObject(defaultProducts).environmentObject(strainStore)
    }
}
#endif
