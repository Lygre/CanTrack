//
//  ContentView.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/9/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

struct HomeView : View {
	@EnvironmentObject var userData: UserData
	@State var selection: Int

	var body: some View {
		NavigationView {
			TabbedView(selection: $selection) {
				InventoryListView().environmentObject(self.userData).tabItemLabel(Text("Inventory"))
					.tag(1)
				Text("Second View")
					.font(.title)
					.tabItemLabel(Image("second"))
					.tag(2)

				}
				.navigationBarItems(leading: NavigationButton(destination: NewProductView(type: self.$userData.defaultProduct).environmentObject(self.userData), onTrigger: { () -> Bool in
					true
				}, label: {
					Text("NewNav")
						.hidden()
				})
					, trailing: PresentationButton(Image(systemName: "bag.badge.plus")
						.imageScale(.large)
						.padding(),
												   destination: NewProductView(type: self.$userData.defaultProduct).environmentObject(self.userData), onTrigger: {
					}))
				.navigationBarTitle(Text("Inventory"), displayMode: .large)

		}
	}



}

#if DEBUG
struct HomeView_Previews : PreviewProvider {
    static var previews: some View {
		HomeView(selection: 1).environmentObject(UserData())
    }
}
#endif
