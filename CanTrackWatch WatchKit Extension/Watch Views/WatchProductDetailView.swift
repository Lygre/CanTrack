//
//  WatchProductView.swift
//  CanTrackWatch WatchKit Extension
//
//  Created by Hugh Broome on 6/28/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI
import Foundation


struct WatchProductDetailView : View {

	var product: Product

	@State private var isOpened: Bool = true


	let dateFormatter: DateFormatter = {
		let dateFormatter2 = DateFormatter()
		dateFormatter2.timeZone = .current
		dateFormatter2.locale = .current
		dateFormatter2.calendar = .current
		dateFormatter2.dateFormat = "MMM d, yyy"
		return dateFormatter2
	}()

    var body: some View {
		VStack(alignment: .leading) {
            Text(product.productType.rawValue)
				.lineLimit(nil)
			Text(product.strain.name)
				.lineLimit(nil)
			Text(product.mass+"g")
			isOpened ? Text(dateFormatter.string(from: product.dateOpened ?? Date())) : Text("Unopened")
        }
		.background(Color.green)
    }
}

#if DEBUG

var testProd: Product = {
	var prod = Product(strain: StrainStore.defaultStrain, productType: .truFlower)
	prod.dateOpened = Date()
	return prod
}()


struct WatchProductView_Previews : PreviewProvider {
    static var previews: some View {
        WatchProductDetailView(product: testProd)
    }
}
#endif
