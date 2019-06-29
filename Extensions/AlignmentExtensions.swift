//
//  AlignmentExtensions.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/28/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI


extension VerticalAlignment {
	private enum ButtonAndLaunchImageVerticalTopAligned: AlignmentID {
		static func defaultValue(in context: ViewDimensions) -> Length {
			return context[.top]
		}
	}

	static let buttonAndLaunchImageVertical = VerticalAlignment(ButtonAndLaunchImageVerticalTopAligned.self)

}


extension HorizontalAlignment {
	private enum ButtonAndLaunchImage: AlignmentID {
		static func defaultValue(in d: ViewDimensions) -> Length {
			return d[HorizontalAlignment.center]
		}
	}

	private enum LaunchScreenArrowAlignment: AlignmentID {
		static func defaultValue(in d: ViewDimensions) -> Length {
			return d[HorizontalAlignment.center]
		}
	}

	static let buttonAndLaunchImage = HorizontalAlignment(ButtonAndLaunchImage.self)

	static let launchScreenArrowAlignment = HorizontalAlignment(LaunchScreenArrowAlignment.self)

}
