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
	@State var selection: Int = 1


	var body: some View {
		NavigationView {
			TabbedView(selection: $selection) {
				Text("First View")
					.font(.title)
					.tabItemLabel(Image("first"))
					.tag(0)
				Text("Second View")
					.font(.title)
					.tabItemLabel(Image("second"))
					.tag(1)

				}
				.navigationBarItems(leading: NavigationButton(destination: NewProductView().environmentObject(self.userData), onTrigger: { () -> Bool in
					true
				}, label: {
					Text("NewNav")
						.hidden()
				})
					, trailing: PresentationButton(Image(systemName: "bag.badge.plus")
						.imageScale(.large)
						.padding(),
												   destination: NewProductView().environmentObject(self.userData), onTrigger: {
					}))
				.navigationBarTitle(Text("Inventory"), displayMode: .large)

		}
	}

	private func createProduct() {
//		let newProduct = self.newDraftProduct
//		self.userData.products.insert(newProduct, at: 0)

	}


}

#if DEBUG
struct HomeView_Previews : PreviewProvider {
    static var previews: some View {
		HomeView().environmentObject(UserData())
    }
}
#endif
