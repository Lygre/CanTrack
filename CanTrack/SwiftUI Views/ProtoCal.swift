//
//  ProtoCal.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/23/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI
import SwiftDate


#if os(tvOS)

struct ProtoCal : View {
	@EnvironmentObject var calendarStore: CalendarStore

	var body: some View {

		NavigationView {
			ProtoYearView()
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
				.navigationBarTitle(Text(calendarStore.activeMonth.description+"  "+CalendarStore.currentDate.year.description))

			}
			.background(Color.init(strainVariety: .indica))
	}

}


#elseif !os(tvOS)

struct ProtoCal : View {
	@EnvironmentObject var calendarStore: CalendarStore

	var body: some View {

		NavigationView {
			HStack(alignment: .top) {
				VStack(alignment: .leading, spacing: 0) {

						ProtoYearView()
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
												displayMode: .automatic)

				}
			}
			}
			.background(Color.init(strainVariety: .indica))
	}

}


#endif


struct ProtoYearView: View {

	var body: some View {
		Group {
			Section {
			ScrollView {
				YearCellView(year: 2019)
				}
			}
			Section(header: HStack {
				Text("Doses for Day")
					.font(.title)
			}) {
				List {
					ForEach((1...18).identified(by: \.identifiedValue)) { int in
						Text("Dose "+int.description)
					}
				}
			}
			.frame(height: 400, alignment: .center)

			Spacer()
		}

	}
}


/// YearCellView
///	year: the given year for the view to populate
///	• is embedded in a VStack aligned leadingly
///
struct YearCellView : View {

	@State private var selectedMonth: Int = Date().month

	var year: Int

	var body: some View {
		VStack(alignment: .leading) {
			HStack(alignment: .top) {
				Text(year.description)
					.font(.title)
					.fontWeight(.heavy)
				ForEach((0...11).identified(by: \.identifiedValue)) { monthInt in
					NavigationLink(destination: MonthCellView(month: Month(rawValue: monthInt)!)) {
						MonthCellView(month: Month(rawValue: monthInt)!)
					}
				}
			}
			}
	}
}

/// MonthRowView
/// Working version of row of months to provide to the yearCellView
///	monthRange: CountableRange, of the months to include in the row; integers correlate to months of the year
///
struct MonthsRowView: View {

	var monthRange: [Month]

	var body: some View {
		HStack(alignment: .center) {
			ForEach(monthRange.identified(by: \.rawValue)) { monthInt in
				MonthCellView(month: monthInt)
			}
		}
//			.frame(width: 350, height: 350, alignment: .leading)
//		.scaledToFill()
	}
}


struct MonthCellView: View {

	var month: Month

	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			Text(month.description[month.description.startIndex...month.description.index(month.description.startIndex, offsetBy: 2)])
			.font(.title)
			.padding(.leading)
			Divider()
			ForEach(0...4) { weekInt in
				WeekRowView(weekInt: weekInt)
			}
				.background(Color(strainVariety: .indica))
		}
		.scaledToFill()
		.padding([.leading, .trailing], 5)
	}
}




struct WeekRowView: View {

	@EnvironmentObject var calendarStore: CalendarStore

	var weekInt: Int



	var body: some View {
		HStack(alignment: .firstTextBaseline) {
			if isWeekStartWeek() {
				Spacer()
			}
			ForEach(calendarStore.weekDates(from: weekInt).identified(by: \.identifiedValue)) { date in
					DayCellView(date: date)
				}
				.lineLimit(nil)
				.padding(EdgeInsets(top: 5, leading: 1, bottom: 5, trailing: 8))

			if isWeekEndWeek() {
				Spacer()
			}

			}
			.background(Color.init(strainVariety: .indica))
	}

	func isWeekStartWeek() -> Bool {
		if weekInt == 0 { return true }
		guard let firstDateInWeek = calendarStore.weekDates(from: weekInt).first else { return false }
		return firstDateInWeek.day == 1

	}

	func isWeekEndWeek() -> Bool {
		if weekInt >= 4 {
			return true
		}
		return false
	}

}

struct DayCellView: View {
	@EnvironmentObject var calendarStore: CalendarStore

	var date: Date
	var dosesForDate: [Dose] = []

	@State private var isSelectedDate: Bool = false
	@State private var hasDoses: Bool = false

	var body: some View {
		VStack(alignment: .center) {
			Image(systemName: "\(calendarStore.dateFormatter.string(from: date))"+".square")
			.imageScale(.large)
			dosesForDate.isEmpty ? nil :
				Image(systemName: "smoke")
					.padding(.bottom)
			}
			.tapAction {
				self.isSelectedDate.toggle()
			}
			.padding([.leading, .trailing, .top, .bottom], 6)
			.background(isSelectedDate ? Color.blue : Color.init(strainVariety: .indica).opacity(0.7))
//		.clipShape(Circle())
	}



}



#if DEBUG

let calendarStore = CalendarStore()

struct ProtoCal_Previews : PreviewProvider {
    static var previews: some View {
        ProtoCal().environmentObject(calendarStore)
    }
}


//struct ProtoYearView_Previews : PreviewProvider {
//	static var previews: some View {
//		ProtoYearView().environmentObject(calendarStore)
//		.previewDevice(.init(rawValue: "iPad7,1"))
//	}
//}
//
//struct YearCellView_Previews : PreviewProvider {
//	static var previews: some View {
//		YearCellView(year: CalendarStore.currentDate.year).environmentObject(calendarStore)
//	}
//}
//-----------------------------------------

//struct MonthsRowView_Previews : PreviewProvider {
//	static var previews: some View {
//		MonthsRowView(monthRange: (0...2).compactMap({ Month(rawValue: $0)!})).environmentObject(calendarStore)
//	}
//}

//-----------------------------------------

//struct MonthCellView_Previews : PreviewProvider {
//	static var previews: some View {
//		MonthCellView(month: Month(rawValue: 5)!).environmentObject(calendarStore)
//	}
//}

//struct WeekRowView_Previews : PreviewProvider {
//	static var previews: some View {
//		WeekRowView(weekInt: 0).environmentObject(calendarStore)
//	}
//}
//
//struct DayCellView_Previews : PreviewProvider {
//	static var previews: some View {
//		DayCellView(date: Date()).environmentObject(calendarStore)
//	}
//}


#endif

