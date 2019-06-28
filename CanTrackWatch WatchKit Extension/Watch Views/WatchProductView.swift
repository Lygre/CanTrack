//
//  WatchProductView.swift
//  CanTrackWatch WatchKit Extension
//
//  Created by Hugh Broome on 6/28/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

struct WatchProductView : View {

	var product: Product

    var body: some View {
        VStack {
            Text(product.productType.rawValue)
			Divider()
			Text(product.strain.name)
			.lineLimit(nil)
        }
    }
}

#if DEBUG

let testProd = defaultProducts.products[0]

struct WatchProductView_Previews : PreviewProvider {
    static var previews: some View {
        WatchProductView(product: testProd)
    }
}
#endif
