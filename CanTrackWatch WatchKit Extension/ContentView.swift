//
//  ContentView.swift
//  CanTrackWatch WatchKit Extension
//
//  Created by Hugh Broome on 6/27/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

let testData2: [String: AnyObject] =
	["strains": StrainStore(strains: [StrainStore.defaultStrain]),
	 "products": defaultProducts
]



struct ContentView : View {

	@State private var productStore: ProductStore = testData2["products"] as! ProductStore
	@State private var strainStore: StrainStore = testData2["strains"] as! StrainStore

	var body: some View {
		VStack {
			ProductImageViewCircular(product: productStore.products[0])
				.alignmentGuide(.buttonAndLaunchImage) { (dimension) -> Length in
					dimension[.bottom] / 2
			}
			Text("Welcome to Can Track")
				.font(.headline)
			HStack(alignment: .firstTextBaseline) {
				Text("Dose →")
				Button(action: {
					//code for button action
				}) {
					Image(systemName: "plus.circle")
						.imageScale(.large)
				}
					.alignmentGuide(.buttonAndLaunchImage) { (dimension) -> Length in
						dimension[.bottom] / 2
				}
			}
			}
			.lineLimit(nil)
			.background(Color.green)
	}
}

#if DEBUG



struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
		ContentView()
    }
}
#endif
