//
//  CalendarView.swift
//  CannTrack
//
//  Created by Hugh Broome on 6/6/19.
//  Copyright © 2019 Lygre. All rights reserved.
//
//
import SwiftUI
import SwiftDate
import SwifterSwift

class IdentRef {
	let value: Int
	init(_ value: Int) {
		self.value = value
	}
}

extension Date: Identifiable {
	typealias RawIdentifier = Date

	public var id: ObjectIdentifier {
		return ObjectIdentifier(IdentRef(self.day))
	}

}


var weekOneDateRange: [[Date]] = { () -> [Date] in
	var dates: [Date] = []
	let startDateOfMonth = Date().dateAtStartOf(.month)
	let endDateOfMonth = Date().dateAtEndOf(.month)
	return Date.enumerateDates(from: startDateOfMonth, to: endDateOfMonth, increment: DateComponents(day: 1))
}().group(by: 7)!


var monthToWeekRowDictionary: [Int: [Date]] = {
	var returnDict: Dictionary<Int, Array<Date>> = [:]

	for weekDateArray in weekOneDateRange {
		let weekNumInMonth = weekDateArray[1].dateAtStartOf(.weekOfMonth).weekOfMonth
		returnDict[weekNumInMonth] = weekNumInMonth == 1 ? Array(weekDateArray.dropFirst()) : weekDateArray
	}

	return returnDict
}()

struct CalendarView : View {


	var dateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = .current
		dateFormatter.locale = .current
		dateFormatter.calendar = .current
		dateFormatter.dateFormat = "mmm DD yyy"
		return dateFormatter
	}()

	var body: some View {
		VStack(alignment: .center, spacing: 0) {
			HStack(alignment: .firstTextBaseline, spacing: 0) {
				Text("Mon")
					.padding()
				Text("Tue")
					.padding()
				Text("Wed")
					.padding()
				Text("Thu")
					.padding()
				Text("Fri")
					.padding()
				Text("Sat")
					.padding()
				Text("Sun")
					.padding()
				}
				.font(.subheadline)
				.background(Color.init("sativaColor"))
				.layoutPriority(1)
				.lineLimit(nil)
				.scaledToFit()
				.cornerRadius(20)

			VStack(alignment: .center, spacing: 1) {
				CalendarRowView(weekRowDateRange: monthToWeekRowDictionary[1]!)
				CalendarRowView(weekRowDateRange: monthToWeekRowDictionary[2]!)
				CalendarRowView(weekRowDateRange: monthToWeekRowDictionary[3]!)
				CalendarRowView(weekRowDateRange: monthToWeekRowDictionary[4]!)
				CalendarRowView(weekRowDateRange: monthToWeekRowDictionary[5]!)
				}
			.scaledToFit()

			Spacer()
			}
//			.scaledToFit()
	}
}



struct CalendarRowView: View {
	var weekRowDateRange: [Date]

	var body: some View {
		HStack(alignment: .center, spacing: 0) {
			ForEach(weekRowDateRange.identified(by: \.id)) { dayInWeek in
				CalendarDateView(date: dayInWeek, dosesForDate: nil)
					.padding(.trailing)
					.padding(.leading)
					Spacer()
				.scaledToFill()
			}

			}
			.scaledToFill()
			.background(Color.init("indicaColor")).scaledToFill()

	}
}



struct CalendarDateView: View {

	var date: Date
	//change this to a binding in the model controller
	var dosesForDate: [Dose]?

	@State private var hasDoses: Bool = false

	var body: some View {
		VStack {
			Text(date.string(withFormat: "d"))
				.padding(.top)
				.padding(.bottom)
			if !dosesForDate.isNilOrEmpty {
				Image(systemName: "smoke")
					.padding(.bottom)
			}
		}
			.background(Color.init("indicaColor").opacity(0.7).scaledToFill())
			.aspectRatio(contentMode: .fill)

	}
}





#if DEBUG
struct CalendarView_Previews : PreviewProvider {
    static var previews: some View {
		CalendarView()
    }
}

//struct CalendarRowView_Previews : PreviewProvider {
//	static var previews: some View {
//		CalendarRowView(weekRowInt: 1)
//	}
//}


#endif
