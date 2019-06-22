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
//import SwifterSwift

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







struct CalendarView : View {
	@EnvironmentObject var calendarStore: CalendarStore


	var body: some View {
		VStack(alignment: .center, spacing: 0) {
			CalendarRowView(weekRowDateRange: [Date(), Date()])
			CalendarRowView(weekRowDateRange: [Date(), Date()])
		}
	}

}



struct CalendarRowView: View {

	var weekRowDateRange: [Date]

	var body: some View {
		HStack(alignment: .firstTextBaseline, spacing: 0) {
			ForEach(weekRowDateRange.identified(by: \.id)) { dayInWeek in
				CalendarDateView(date: dayInWeek)
					.padding(.trailing)
					.padding(.leading)
			}.background(Color.init("indicaColor"))

			}
			.scaledToFit()


	}
}



struct CalendarDateView: View {

	var date: Date
	//change this to a binding in the model controller
	var dosesForDate: [Dose] = []

	@State private var hasDoses: Bool = false

	var body: some View {
		VStack {
			Text(calendarStore.dateFormatter.string(from: date))
				.padding(.top)
				.padding(.bottom)
			dosesForDate.isEmpty ? nil :
				Image(systemName: "smoke")
					.padding(.bottom)
			}
			.background(Color.init(strainVariety: .indica).opacity(0.7))
			.aspectRatio(contentMode: .fill)
		}

}





#if DEBUG

let calendarStore = CalendarStore()

struct CalendarView_Previews : PreviewProvider {
    static var previews: some View {
		CalendarView().environmentObject(calendarStore)
    }
}

struct CalendarRowView_Previews : PreviewProvider {
	static var previews: some View {
		CalendarRowView(weekRowDateRange: [Date()])
	}
}


#endif
