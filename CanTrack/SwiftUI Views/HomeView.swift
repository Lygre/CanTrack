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
//	@EnvironmentObject var userData: UserData
//	@EnvironmentObject var productStore: ProductStore

	@State var selection: Int
	

	var body: some View {
			TabbedView(selection: $selection) {
				InventoryListView()

					.tabItemLabel(Text("Inventory"))
					.tag(1)
					StrainsView().environmentObject(UserData())
					.tabItemLabel(Text("Strains"))
					.tag(2)

				}.navigationBarTitle(Text("Inventory"), displayMode: .large)


	}



}

#if DEBUG
struct HomeView_Previews : PreviewProvider {
    static var previews: some View {
		HomeView(selection: 1)
    }
}
#endif
