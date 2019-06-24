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
		VStack(alignment: .leading) {
			CalendarRowView(weekRowDateRange: calendarStore.weekDates(from: 0))
			CalendarRowView(weekRowDateRange: calendarStore.weekDates(from: 1)).scaledToFill()
			CalendarRowView(weekRowDateRange: calendarStore.weekDates(from: 2))
			CalendarRowView(weekRowDateRange: calendarStore.weekDates(from: 3))
			CalendarRowView(weekRowDateRange: calendarStore.weekDates(from: 4))
		}


	}

}



struct CalendarRowView: View {

	var weekRowDateRange: [Date]

	var body: some View {
		VStack(alignment: .center) {
         HStack {
             ForEach(weekRowDateRange.identified(by: \.id)) { dayInWeek in
                 CalendarDateView(date: dayInWeek)
                     .padding(.trailing)
                     .padding(.leading)
                     }.background(Color.init("indicaColor"))

                 }

         }
			.background(Color.init(strainVariety: .indica))
			.scaledToFill()

	}
}



struct CalendarDateView: View {

	var date: Date
	//change this to a binding in the model controller
	var dosesForDate: [Dose] = []

	@State private var hasDoses: Bool = false

	var body: some View {
		VStack(alignment: .center) {
			Text(calendarStore.dateFormatter.string(from: date))
				.padding(.top)
				.padding(.bottom)
			dosesForDate.isEmpty ? nil :
				Image(systemName: "smoke")
					.padding(.bottom)
			}
			.background(Color.init(strainVariety: .indica).opacity(0.7))
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
		CalendarRowView(weekRowDateRange: calendarStore.weekDates(from: 1))
	}
}


#endif
