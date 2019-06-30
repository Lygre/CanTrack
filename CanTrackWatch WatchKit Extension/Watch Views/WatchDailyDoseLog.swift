//
//  WatchDailyDoseLog.swift
//  CanTrackWatch WatchKit Extension
//
//  Created by Hugh Broome on 6/29/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

struct WatchDailyDoseLog : View {
	@EnvironmentObject var doseStore: DoseStore

	@State private var doseLogsRetrievedDate: Date = Date()

	let daysDosesHeadingDateFormatter: DateFormatter = {
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
						self.changeDate(forLogs: -1)
					}) {
						Image(systemName: "chevron.left.circle")
					}
					Spacer()
					Text(daysDosesHeadingDateFormatter.string(from: doseLogsRetrievedDate))
						.font(.headline)
					Spacer()
					Button(action: {
						self.changeDate(forLogs: 1)
					}) {
						Image(systemName: "chevron.right.circle")
					}
					}
					.imageScale(.large)
				}.padding(.top)

			List {
				Section {
					ForEach(doseStore.doses.filter({
						$0.timestamp.currentCalendar.components.year == doseLogsRetrievedDate.currentCalendar.components.year
					}).identified(by: \.hashValue)) { dose in
						Text(self.daysDosesDateFormatter.string(from: dose.timestamp))
					}
				}
			}

		}.navigationBarTitle(Text("Dose Log \(navigationBarYearDateFormatter.string(from: doseLogsRetrievedDate))"))
	}



	func changeDate(forLogs by: Int) {
		switch by > 0 {
		case true:
			self.doseLogsRetrievedDate.addTimeInterval(TimeInterval(86400))
		case false:
			self.doseLogsRetrievedDate.addTimeInterval(TimeInterval(-86400))
		}

	}

}

#if DEBUG
struct WatchDailyDoseLog_Previews : PreviewProvider {
    static var previews: some View {
        WatchDailyDoseLog().environmentObject(testDoseStore)
    }
}
#endif