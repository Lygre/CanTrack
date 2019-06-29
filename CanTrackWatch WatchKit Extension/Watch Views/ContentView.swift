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
		VStack(alignment: .leading) {
			HStack(alignment: .center) {
				ProductImageViewCircular(product: productStore.products[1])
				Text("CanTrack")
					.lineLimit(nil)
					.font(.headline)
			}
			
			HStack {
				Text("Dose →")

				NavigationButton(destination: WatchProductsListView().environmentObject(self.productStore).environmentObject(self.strainStore)) {
					Image(systemName: "plus.circle")
						.imageScale(.large)
						.foregroundColor(Color.blue)
				}

				}
				Spacer()
				.lineLimit(nil)
				.background(Color.green)
		}
	}
}

#if DEBUG



struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
		ContentView().environmentObject(productStore).environmentObject(strainStore)
    }
}
#endif
