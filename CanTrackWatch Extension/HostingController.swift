//
//  HostingController.swift
//  CanTrackWatch Extension
//
//  Created by Hugh Broome on 6/26/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController : WKHostingController<ContentView> {

	var productStore: ProductStore = ProductStore(products: testData)
	var strainStore: StrainStore = StrainStore(strains: testData.compactMap({ return $0.strain }))

    override var body: ContentView {
        return ContentView()
    }
}
