//
//  WatchDailyDoseLog.swift
//  CanTrackWatch WatchKit Extension
//
//  Created by Hugh Broome on 6/29/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI
import Datez



struct WatchDailyDoseLog : View {

	enum DateChangeVector {
		case forward
		case backward
	}

	@EnvironmentObject var userData: UserData

	@State private var doseLogsRetrievedDate: Date = Date()

	let dailyDoseLogDateFormatter: DateFormatter = {
		var formatter = DateFormatter()
		formatter.timeZone = .current
		formatter.locale = .current
		formatter.calendar = .current
		formatter.dateFormat = "MMM d"
		return formatter
	}()

	let daysDosesDateFormatter: DateFormatter = {
		var formatter = DateFormatter()
		formatter.timeZone = .current
		formatter.locale = .current
		formatter.calendar = .current
		formatter.timeStyle = .medium
		formatter.dateStyle = .none
		return formatter
	}()

	let navigationBarYearDateFormatter: DateFormatter = {
		var formatter = DateFormatter()
		formatter.timeZone = .current
		formatter.locale = .current
		formatter.calendar = .current
		formatter.dateFormat = "yyy"
		return formatter
	}()

	var body: some View {
		VStack(alignment: .center) {
			Group {
				HStack {
					Button(action: {
						self.changeDate(in: .backward)
					}) {
						Image(systemName: "chevron.left.circle")
					}
					Spacer()
					Text(dailyDoseLogDateFormatter.string(from: doseLogsRetrievedDate))
						.font(.headline)
					Spacer()
					Button(action: {
						self.changeDate(in: .forward)
					}) {
						Image(systemName: "chevron.right.circle")
					}
					}
					.imageScale(.large)
				}.padding(.top)

			List {
				Section {
					ForEach(userData.doses.filter({
						(($0.timestamp.currentCalendar.components.year == doseLogsRetrievedDate.currentCalendar.components.year) &&
							($0.timestamp.currentCalendar.components.month == doseLogsRetrievedDate.currentCalendar.components.month) &&
							($0.timestamp.currentCalendar.components.day == doseLogsRetrievedDate.currentCalendar.components.day))
					}).identified(by: \.id)) { dose in
						NavigationLink(destination: DoseDetail(dose: dose).environmentObject(self.userData)) {
							Text(self.daysDosesDateFormatter.string(from: dose.timestamp))
						}
					}
				}
			}
		}.navigationBarTitle(Text("Dose Log \(navigationBarYearDateFormatter.string(from: doseLogsRetrievedDate))"))
	}



	func changeDate(in direction: DateChangeVector) {
		switch direction {
		case .forward:
			let tomorrow = (doseLogsRetrievedDate.gregorian + 1.day).date
			self.doseLogsRetrievedDate = tomorrow
		case .backward:
			let yesterday = (doseLogsRetrievedDate.gregorian - 1.day).date
			self.doseLogsRetrievedDate = yesterday
		}

	}

}

#if DEBUG
struct WatchDailyDoseLog_Previews : PreviewProvider {
    static var previews: some View {
        WatchDailyDoseLog().environmentObject(UserData())
    }
}
#endif
