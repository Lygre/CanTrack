//
//  ContentView.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/9/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI
import Combine
//let productStore = ProductStore()

struct HomeView : View {
	@EnvironmentObject var userData: UserData
	@EnvironmentObject var productStore: ProductStore

	@State private var selection: Int = 0
	

	var body: some View {
		TabbedView(selection: $selection) {
			InventoryListView().environmentObject(productStore).environmentObject(userData)
				.tabItemLabel(Text("Inventory"))
				.tag(0)
			StrainsView().environmentObject(userData).environmentObject(productStore)
				.tabItemLabel(Text("Strains"))
				.tag(1)
			}
			.navigationBarTitle(Text("Inventory"), displayMode: .large)
	}



}

#if DEBUG
struct HomeView_Previews : PreviewProvider {
    static var previews: some View {
		NavigationView {
			HomeView()
		}.environmentObject(UserData()).environmentObject(ProductStore(products: testData))
    }
}
#endif
