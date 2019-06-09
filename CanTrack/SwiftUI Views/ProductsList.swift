//
//  ProductsList.swift
//  CannTrack
//
//  Created by Hugh Broome on 6/4/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

struct ProductsList : View {
	var body: some View {
		NavigationView {
			List(inventory) { product in
				NavigationButton(destination: ProductDetailView(product: product)) {
					ProductRow(product: product)
				}
			}
			}
   .navigationBarTitle(Text("Inventory Products List"))
   .background(Color.blue)
	}
}

#if DEBUG
struct ProductsList_Previews : PreviewProvider {
    static var previews: some View {
        ProductsList()
    }
}
#endif
