//
//  UserData.swift
//  CanTrack
//
//  Created by Hugh Broome on 7/2/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI
import Combine


final class UserData: BindableObject {

	let didChange = PassthroughSubject<UserData, Never>()

	var doses = DoseStore.shared.doses {
		didSet {
			didChange.send(self)
			DoseStore.shared.doses = doses
		}
	}


}
