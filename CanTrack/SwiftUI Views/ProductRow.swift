//
//  ProductRow.swift
//  CannTrack
//
//  Created by Hugh Broome on 6/4/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

struct ProductRow : View {
	var product: Product

	@State private var showDetail = false

	var body: some View {
		HStack {

			ProductImageViewCircular(product: product)
				.padding(.all)
			Spacer()
			VStack(alignment: .leading) {
				Text(product.strain.name)
					.lineLimit(nil)

				HStack {
					VStack(alignment: .leading) {
						Text(product.productType.rawValue)

							.lineLimit(nil)
						Text(product.strain.race.rawValue.capitalized)
							.lineLimit(nil)

}


					Text(product.mass.description+" g")
						.padding(.trailing, 3)
				}


}

			}
			.background(Color.init(strainVariety: product.strain.race)).opacity(0.7)
			.scaledToFill()
			.cornerRadius(4, antialiased: true)



	}
}


#if DEBUG
struct ProductRow_Previews : PreviewProvider {
    static var previews: some View {
        ProductRow(product: ProductStore(products: defaultProducts.products).products[1])

    }
}

#endif
