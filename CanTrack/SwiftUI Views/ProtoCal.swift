//
//  ProtoCal.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/23/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI
import SwiftDate

//#if os(tvOS)
//NSLog("Code compuled only when building for tvOS");
//#endif

#if os(tvOS)

struct ProtoCal : View {


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
			.background(Color.init(strainVariety: .indica))
	}

}


#endif


struct ProtoYearView: View {

	var body: some View {
		NavigationView {
			VStack(spacing: 0) {
				ScrollView(isScrollEnabled: true, showsVerticalIndicator: false) {
					VStack {
						//					ForEach(2018...2019) { year in
						//						YearCellView(year: year)
						//					}
						YearCellView(year: 2019)

						}.aspectRatio(contentMode: .fit)

					}.navigationBarItems(leading:
						Image(systemName: "magnifyingglass.circle")
							.imageScale(.large),
										 trailing:
						HStack(spacing: 9) {
							Image(systemName: "list.bullet.below.rectangle")
							Spacer()
							Image(systemName: "plus")
							}
							.imageScale(.large))
					.navigationBarTitle(Text("Dose Calendar"))
				List {
					ForEach((1...5).identified(by: \.identifiedValue)) { int in
						Text("Dose "+int.description)
					}
				}
			}
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
		VStack(alignment: .center) {
			HStack {
			Text(year.description)
				.font(.title)
				.fontWeight(.heavy)
			Divider()
//			MonthsRowView(monthRange: (0...2).compactMap({ Month(rawValue: $0)!})).scaledToFit()
			ForEach((0...11).identified(by: \.identifiedValue)) { monthInt in
				MonthCellView(month: Month(rawValue: monthInt)!)
			}
//			MonthCellView(month: Month.january)
			}
			}
//			.padding(.leading)
//			.scaledToFill()
		.aspectRatio(contentMode: .fit)
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
			}.background(Color(strainVariety: .indica))
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
			.scaledToFill()
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

	@State private var hasDoses: Bool = false

	var body: some View {
		VStack(alignment: .center) {
			Image(systemName: "\(calendarStore.dateFormatter.string(from: date))"+".square")
			.imageScale(.large)
			dosesForDate.isEmpty ? nil :
				Image(systemName: "smoke")
					.padding(.bottom)
			}
			.padding([.leading, .trailing, .top, .bottom], 6)
			.background(Color.init(strainVariety: .indica).opacity(0.7))
//		.clipShape(Circle())
	}



}



#if DEBUG

let calendarStore = CalendarStore()

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
//
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

