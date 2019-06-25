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
	@EnvironmentObject var productStore: ProductStore
	@EnvironmentObject var strainStore: StrainStore
	@EnvironmentObject var calendarStore: CalendarStore

	@State var selectedTab = Tab.inventory

	enum Tab: Int {
		case inventory, strains, calendar
	}

	enum TabNames: String {
		case inventory = "Inventory"
		case strains = "Strains"
		case calendar = "Calendar"

		init(from tabEnumType: Tab) {
			switch tabEnumType {
			case .inventory:
				self = TabNames.inventory
			case .strains:
				self = TabNames.strains
			case .calendar:
				self = TabNames.calendar
			}
		}
	}

	var body: some View {
		TabbedView(selection: $selectedTab) {
			InventoryListView().tabItemLabel(Text("Inventory")).tag(Tab.inventory)
			StrainsView().tabItemLabel(Text("Strains")).tag(Tab.strains)
			ProtoYearView().tabItemLabel(Text("Calendar")).tag(Tab.calendar)
			}
			.environmentObject(store)
			.environmentObject(strainStore)
			.environmentObject(calendarStore)

		//			.edgesIgnoringSafeArea(.top)
	}

}

#if DEBUG

let userData = UserData()

struct HomeView_Previews : PreviewProvider {
    static var previews: some View {
			HomeView().environmentObject(store).environmentObject(strainStore).environmentObject(calendarStore)
    }
}
#endif
