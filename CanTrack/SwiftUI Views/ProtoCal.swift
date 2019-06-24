//
//  ProtoCal.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/23/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

struct ProtoCal : View {
	var body: some View {
		NavigationView {
			CalendarView()
				.navigationBarItems(trailing:
					HStack(spacing: 9) {
						Image(systemName: "list.bullet.below.rectangle")
						Spacer()
						Image(systemName: "magnifyingglass.circle")
						Spacer()
						Image(systemName: "plus")
						}
						.imageScale(.large)
				)
				.navigationBarTitle(Text(calendarStore.activeMonth.description+"  "+CalendarStore.currentDate.year.description),
					displayMode: .automatic
			).background(Color.init(strainVariety: .indica))
		}

	}

}

struct ProtoYearView: View {

	var body: some View {
		NavigationView {
			ScrollView(isScrollEnabled: true, showsVerticalIndicator: true) {
				VStack(alignment: .leading) {
					Text(CalendarStore.currentDate.year.description)
						.font(.title)
						.fontWeight(.heavy)
						.padding(.leading)
					Divider()
					Text("The end is nigh and the dark is full of terrors")
					}
					.scaledToFill()

				}.navigationBarItems(trailing: HStack(spacing: 9) {
					Image(systemName: "magnifyingglass")
					Spacer()
					Image(systemName: "plus")
					}
					.imageScale(.large)
				)
				.foregroundColor(.init(strainVariety: .indica))

		}
	}
}

#if DEBUG
struct ProtoCal_Previews : PreviewProvider {
    static var previews: some View {
        ProtoCal().environmentObject(calendarStore)
    }
}

struct ProtoYearView_Previews : PreviewProvider {
	static var previews: some View {
		ProtoYearView().environmentObject(calendarStore)
	}
}
#endif
