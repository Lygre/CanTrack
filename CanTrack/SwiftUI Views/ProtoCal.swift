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
				VStack {
					ForEach(2017...2025) { year in
						YearCellView(year: year)
					}

				}

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


struct YearCellView : View {

	var year: Int

	var body: some View {
		VStack(alignment: .leading) {
			Text(year.description)
				.font(.title)
				.fontWeight(.heavy)

			Divider()
			.padding(.leading)
			Text("The end is nigh and the dark is full of terrors")
			}
			.scaledToFill()
	}
}

#if DEBUG
//struct ProtoCal_Previews : PreviewProvider {
//    static var previews: some View {
//        ProtoCal().environmentObject(calendarStore)
//    }
//}

struct ProtoYearView_Previews : PreviewProvider {
	static var previews: some View {
		ProtoYearView().environmentObject(calendarStore)
	}
}

struct YearCellView_Previews : PreviewProvider {
	static var previews: some View {
		YearCellView(year: CalendarStore.currentDate.year).environmentObject(calendarStore)
	}
}
#endif

