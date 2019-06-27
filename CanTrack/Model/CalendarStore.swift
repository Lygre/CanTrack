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

extension Month: Codable { }


/// CalendarStore
/// Serves as the Bindable object to publish changes to the dose log
class CalendarStore: Codable, BindableObject {

	/// Coding Keys
	enum CodingKeys: String, CodingKey {
		case datesForMonth
		case activeMonth
	}

	static let currentDate: Date = Date()

	//MARK: Bindable Object Conformance
	let didChange = PassthroughSubject<Void, Never>()

	//MARK: CONSTANTS
	let masterDateStoreArray: [Date]

	//MARK: PROPERTIES
	var datesForMonth: [Date] = [] {
		didSet {
			didChange.send()
		}
	}

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

	//MARK: COMPUTED PROPERTIES
	lazy var dateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = .current
		dateFormatter.locale = .current
		dateFormatter.calendar = .current
		dateFormatter.dateFormat = "d"
		return dateFormatter
	}()


	//MARK: Initialization & Codable Conformance
	init() {
		self.activeMonth = Month(rawValue: CalendarStore.currentDate.month)!
		self.datesForMonth = {
			return Date.enumerateDates(from: CalendarStore.currentDate.dateAtStartOf(.month), to: CalendarStore.currentDate.dateAtEndOf(.month), increment: DateComponents(day: 1))
		}()
		self.masterDateStoreArray = CalendarStore.generateDatesArray(between: 2018, year2: 2020)
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
			self.masterDateStoreArray = CalendarStore.generateDatesArray(between: 2018, year2: 2020)
		} catch {
			activeMonth = Month(rawValue: 1)!
			datesForMonth = [

			]
			self.masterDateStoreArray = CalendarStore.generateDatesArray(between: 2018, year2: 2020)
			print(error)
		}
	}

	//MARK: Type Methods
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

}

//MARK: Hashable and Equatable Conformance
extension CalendarStore: Hashable, Equatable {
	static func == (lhs: CalendarStore, rhs: CalendarStore) -> Bool {
		return lhs.datesForMonth == rhs.datesForMonth
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(datesForMonth)
	}
}

//MARK: HELPER METHODS
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



}

extension Date {

	var isFirstDayOfMonth: Bool {
		get {
			return self == self.dateAtStartOf(.month)
		}
	}

}
