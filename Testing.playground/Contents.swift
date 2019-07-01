import UIKit
import Foundation

let navigationBarFormatter: DateFormatter = {
	var formatter = DateFormatter()
	formatter.timeZone = .current
	formatter.locale = .current
	formatter.calendar = .current
	formatter.timeStyle = .short
	formatter.dateStyle = .none
	formatter.dateFormat = "MMM d"
	return formatter
}()

print(navigationBarFormatter.string(from: Date()))
