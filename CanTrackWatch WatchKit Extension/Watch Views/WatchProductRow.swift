//
//  WatchProductView.swift
//  CanTrackWatch WatchKit Extension
//
//  Created by Hugh Broome on 6/28/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI
import Foundation


struct WatchProductRow : View {

	var product: Product

	@State private var isOpened: Bool = true


	

	var body: some View {
		HStack {
//			Image(systemName: "smoke.fill")
			product.image(forSize: 20)
			VStack(alignment: .leading) {
				Text(product.productType.rawValue)
					.lineLimit(nil)
					.multilineTextAlignment(.leading)
				Text(product.strain.name)
					.lineLimit(nil)
					.alignmentGuide(.trailing) { (dimension) -> Length in
						dimension[.trailing]
				}
			}
			Spacer()
		}
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
        WatchProductRow(product: testProd)
    }
}
#endif
