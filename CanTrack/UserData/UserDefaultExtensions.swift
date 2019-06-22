//
//  UserDefaultExtensions.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/22/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

@propertyWrapper
struct UserDefault<T: Codable> {
	let key: String
	let defaultValue: T

	init(_ key: String, defaultValue: T) {
		self.key = key
		self.defaultValue = defaultValue
		UserDefaults.standard.register(defaults: [key: defaultValue])
	}

	var value: T {
		get {
			return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
		}
		set {
			UserDefaults.standard.set(newValue, forKey: key)
		}
	}

}
