//
//  CalendarStore.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/22/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import SwiftDate

extension Month: Codable {

}

class CalendarStore: Equatable, Hashable, Codable, BindableObject {
	static func == (lhs: CalendarStore, rhs: CalendarStore) -> Bool {
		return lhs.datesForMonth == rhs.datesForMonth
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(datesForMonth)
	}

	var dateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = .current
		dateFormatter.locale = .current
		dateFormatter.calendar = .current
		dateFormatter.dateFormat = "d"
		return dateFormatter
	}()

	let didChange = PassthroughSubject<Void, Never>()

	static let currentDate: Date = Date()

	var activeMonth: Month {
		didSet {
			didChange.send()
			self.datesForMonth = {
				var cmp = DateComponents()
				cmp.timeZone = .current
				cmp.calendar = .current
				cmp.calendar?.locale = .current
				cmp.year = CalendarStore.currentDate.year
				cmp.month = self.activeMonth.rawValue
				cmp.day = 1
				cmp.hour = 2
				cmp.minute = 2
				guard let dateForGeneration = try? Date(components: cmp, region: nil) else {
					return []
				}
				return Date.enumerateDates(from: dateForGeneration.dateAtStartOf(.month), to: dateForGeneration.dateAtEndOf(.month), increment: DateComponents(day: 1))
			}()
		}
	}


	init() {
		self.activeMonth = Month(rawValue: CalendarStore.currentDate.month)!
		self.datesForMonth = {
			return Date.enumerateDates(from: CalendarStore.currentDate.dateAtStartOf(.month), to: CalendarStore.currentDate.dateAtEndOf(.month), increment: DateComponents(day: 1))
		}()
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(datesForMonth, forKey: .datesForMonth)
		try container.encode(activeMonth, forKey: .activeMonth)
	}

	required init(from aDecoder: Decoder) {
		do {
			let values = try aDecoder.container(keyedBy: CodingKeys.self)
			activeMonth = try values.decode(Month.self, forKey: .activeMonth)
			datesForMonth = try values.decode([Date].self, forKey: .datesForMonth)
		} catch {
			activeMonth = Month(rawValue: 1)!
			datesForMonth = [

			]
			print(error)
		}
	}

	enum CodingKeys: String, CodingKey {
		case datesForMonth
		case activeMonth
	}

	var datesForMonth: [Date] = [] {
		didSet {
			didChange.send()
		}
	}

}

extension CalendarStore {

	func weekDates(from weekNum: Int) -> [Date] {
		guard let startDate = try Date(components: DateComponents(month: activeMonth.rawValue), region: nil) else {
			return []
		}
		let startDateBase = startDate.dateByAdding(weekNum, .weekOfMonth)
		let startDateToReturn = startDateBase.dateAtStartOf(.weekOfMonth)
		let endDateToReturn = startDateBase.dateAtEndOf(.weekOfMonth)

		var cmp = DateComponents()
		cmp.timeZone = .current
		cmp.calendar = .current
		cmp.calendar?.locale = .current
		cmp.year = CalendarStore.currentDate.year
		cmp.month = self.activeMonth.rawValue
		cmp.day = startDateBase.day
		cmp.hour = 2
		cmp.minute = 2
		return Date.enumerateDates(from: startDateToReturn.date, to: endDateToReturn.date, increment: DateComponents(day: 1))
	}


}
