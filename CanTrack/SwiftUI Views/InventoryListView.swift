//
//  InventoryListView.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/9/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

struct InventoryListView : View {
	@EnvironmentObject var userData: UserData

	var body: some View {
		return VStack {
			List(self.userData.products) { product in
				NavigationButton(destination: ProductDetailView(product: product).environmentObject(self.userData)) { ProductRow(product: product)
				}

			}
		}
	}
}

#if DEBUG
struct InventoryListView_Previews : PreviewProvider {
    static var previews: some View {
        InventoryListView().environmentObject(UserData())
    }
}
#endif
