//
//  HostingController.swift
//  CanTrackWatch WatchKit Extension
//
//  Created by Hugh Broome on 6/27/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI


class HostingController : WKHostingController<AnyView> {
    override var body: AnyView {
		return AnyView(ContentView().environmentObject(UserData()))
    }
}
