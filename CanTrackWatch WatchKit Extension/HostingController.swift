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

let testData: [String: AnyObject] =
	["strains": StrainStore(strains: [StrainStore.defaultStrain]),
	 "products": defaultProducts
]

class HostingController : WKHostingController<ContentView> {

	var strainStore: StrainStore = testData["strains"] as! StrainStore
	var productStore: ProductStore = testData["products"] as! ProductStore
	
    override var body: ContentView {
		return ContentView(productStore: productStore, strainStore: strainStore)
    }
}
