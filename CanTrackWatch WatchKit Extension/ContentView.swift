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
        HStack {
            Text("Hello World")
			ProductImageViewCircular(product: productStore.products[0])
        }
    }
}

#if DEBUG



struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
		ContentView()
    }
}
#endif
