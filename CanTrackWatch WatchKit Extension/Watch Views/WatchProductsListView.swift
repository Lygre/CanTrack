//
//  WatchProductsListView.swift
//  CanTrackWatch WatchKit Extension
//
//  Created by Hugh Broome on 6/28/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

struct WatchProductsListView : View {
	@EnvironmentObject var userData: UserData

	@State private var favoritesFilterOn: Bool = false

	var body: some View {
		List {
			Toggle(isOn: $favoritesFilterOn) {
				Text("Favorites Only")
			}
			ForEach(userData.products.identified(by: \.id)) { product in
				if !self.favoritesFilterOn || product.isFavorite {
					NavigationButton(destination:
						WatchProductDetail(product: product)
							.environmentObject(self.userData)
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
        WatchProductsListView().environmentObject(UserData())
    }
}
#endif
