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

	@EnvironmentObject var calendarStore: CalendarStore

	@State private var selectedTab = Tab.inventory.rawValue

	enum Tab: Int, Hashable {
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
	#if !os(tvOS)
	var body: some View {
		TabbedView(selection: $selectedTab) {
			InventoryListView()
			}
			.environmentObject(userData)
			.environmentObject(calendarStore)

		//			.edgesIgnoringSafeArea(.top)
	}
	#endif
	#if os(tvOS)
	var body: some View {
		NavigationView {
			TabbedView(selection: $selectedTab) {
				InventoryListView().tabItemLabel(Text("Inventory")).tag(Tab.inventory)
				StrainsView().tabItemLabel(Text("Strains")).tag(Tab.strains)
				ProtoYearView().tabItemLabel(Text("Calendar")).tag(Tab.calendar)
			}
			}
//		.environmentObject(userData)
	}
	#endif


}

#if DEBUG


struct HomeView_Previews : PreviewProvider {
    static var previews: some View {
			HomeView()
				.environmentObject(UserData())
				.environmentObject(calendarStore)
    }
}
#endif
