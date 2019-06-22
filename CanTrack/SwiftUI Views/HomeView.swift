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

	@State private var selection: Int = 1
	

	var body: some View {
		TabbedView(selection: $selection) {
			InventoryListView()
				.tag(1)
				.tabItemLabel(Text("Inventory"))

			StrainsView().environmentObject(userData)
				.tag(2)
				.tabItemLabel(Text("Strains"))

			}
			.navigationBarTitle(Text("Inventory"), displayMode: .large)
	}



}

#if DEBUG

let userData = UserData()

struct HomeView_Previews : PreviewProvider {
    static var previews: some View {
		NavigationView {
			HomeView()
		}.environmentObject(userData).environmentObject(store)
    }
}
#endif
