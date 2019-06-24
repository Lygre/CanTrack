//
//  ProtoCal.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/23/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI
import SwiftDate

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


/// YearCellView
///	year: the given year for the view to populate
///	• is embedded in a VStack aligned leadingly
///
struct YearCellView : View {

	var year: Int

	var body: some View {
		VStack(alignment: .leading) {
			Text(year.description)
				.font(.title)
				.fontWeight(.heavy)
			Divider()
			Text("MonthRowView PlaceholderView")
			}
			.padding(.leading)
			.scaledToFill()
	}
}

/// MonthRowView
/// Working version of row of months to provide to the yearCellView
///	monthRange: CountableRange, of the months to include in the row; integers correlate to months of the year
///
struct MonthsRowView: View {

	var monthRange: [Month]

	var body: some View {
		HStack {
			ForEach(monthRange.identified(by: \.rawValue)) { monthInt in
				Text(monthInt.description)
			}
		}
	}
}


struct MonthCellView: View {

	var month: Month

	var body: some View {
		VStack(alignment: .leading) {
			Text(month.description[month.description.startIndex...month.description.index(month.description.startIndex, offsetBy: 2)])
			.font(.title)
			Divider()
			Text("Placeholder for ForEach of week row views")
		}
		.padding([.leading, .trailing], 5)
	}
}




struct WeekRowView: View {

	var weekInt: Int

	let datesForWeek: [Date] = {
		return calendarStore.weekDates(from: 0)
	}()

	var body: some View {
		HStack {
			ForEach(datesForWeek.identified(by: \.id)) { date in
				DayCellView(date: date)
			}
			}
			.padding([.leading, .trailing], 5)
	}
}

struct DayCellView: View {

	var date: Date
	var dosesForDate: [Dose] = []

	@State private var hasDoses: Bool = false

	var body: some View {
		VStack(alignment: .center) {
			Text(calendarStore.dateFormatter.string(from: date))
			dosesForDate.isEmpty ? nil :
				Image(systemName: "smoke")
					.padding(.bottom)
			}
			.padding([.leading, .trailing, .top, .bottom], 6)
			.background(Color.init(strainVariety: .indica).opacity(0.7))
		.clipShape(Circle())
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

struct MonthsRowView_Previews : PreviewProvider {
	static var previews: some View {
		MonthsRowView(monthRange: (0...2).compactMap({ Month(rawValue: $0)!})).environmentObject(calendarStore)
	}
}

struct MonthCellView_Previews : PreviewProvider {
	static var previews: some View {
		MonthCellView(month: Month(rawValue: 1)!).environmentObject(calendarStore)
	}
}

struct WeekRowView_Previews : PreviewProvider {
	static var previews: some View {
		WeekRowView(weekInt: 1).environmentObject(calendarStore)
	}
}

struct DayCellView_Previews : PreviewProvider {
	static var previews: some View {
		DayCellView(date: Date()).environmentObject(calendarStore)
	}
}


#endif

