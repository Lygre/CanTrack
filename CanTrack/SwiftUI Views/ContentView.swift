//
//  ContentView.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/9/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

struct ContentView : View {
	@State var selection: Int
 
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

				}.navigationBarTitle(Text("Inventory")).navigationBarItems(leading: Text("New"), trailing: Image(systemName: "bag.badge.plus")
							.imageScale(.large)
						.padding()
				)
		}
	}
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
		ContentView(selection: 1)
    }
}
#endif
