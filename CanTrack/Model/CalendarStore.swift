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

	let masterDateStoreArray: [Date]

	static func generateDatesArray(between year1: Int, year2: Int) -> [Date] {
		return Date.enumerateDates(from: CalendarStore.firstDayOfYear(year: year1), to: CalendarStore.firstDayOfYear(year: year2), increment: DateComponents(day: 1))
	}
	static func firstDayOfYear(year: Int) -> Date {
		var cmp = DateComponents()
		cmp.timeZone = .current
		cmp.calendar = .current
		cmp.calendar?.locale = .current
		cmp.year = year
		cmp.month = 1
		cmp.day = 1
		cmp.hour = 2
		guard let dateForGeneration = try? Date(components: cmp, region: nil) else {
			return Date()
		}
		return dateForGeneration.dateAtStartOf(.year)
	}

//	func getNumberOfWeeks(for monthInt: Int) -> Int {
//		//wekday ordinals
//		let daysInMonth: Int = masterDateStoreArray.filter({ $0.dateAt(weekdayOrdinal: 0, weekday: .monday, monthNumber: self.activeMonth.rawValue, yearNumber: 2019).isLeapYear })
//	}

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
		self.masterDateStoreArray = CalendarStore.generateDatesArray(between: 2012, year2: 2021)
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
			self.masterDateStoreArray = CalendarStore.generateDatesArray(between: 2012, year2: 2021)
		} catch {
			activeMonth = Month(rawValue: 1)!
			datesForMonth = [

			]
			self.masterDateStoreArray = CalendarStore.generateDatesArray(between: 2012, year2: 2021)
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
		return Date.enumerateDates(from: startDateToReturn.date, to: endDateToReturn.date, increment: DateComponents(day: 1)).filter { (someDate) -> Bool in
			return someDate.isInRange(date: startDateBase.dateAtStartOf(.month).date, and: startDateBase.dateAtEndOf(.month).date)
		}
	}

//	func getDatesForWeekRowView(weekInt: Int) -> [Date] {
//
//
//	}

}

extension Date {

	var isFirstDayOfMonth: Bool {
		get {
			return self == self.dateAtStartOf(.month)
		}
	}

}
