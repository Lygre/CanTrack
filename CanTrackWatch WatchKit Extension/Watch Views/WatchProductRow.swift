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
			product.image(forSize: 36)
				.clipShape(Circle())

			VStack(alignment: .leading) {
				Text(product.productType.rawValue)
					.lineLimit(nil)
				Text(product.strain.name)
					.lineLimit(nil)
					.alignmentGuide(.trailing) { (dimension) -> Length in
						dimension[.trailing]
				}
			}



			if product.isFavorite {
				Image(systemName: "star.fill")
					.imageScale(.medium)
				.foregroundColor(Color.yellow)
			}
			Spacer()

			}
			.padding([.top, .bottom], Length(exactly: 2))
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
