//
//  ProductDetailView.swift
//  CannTrack
//
//  Created by Hugh Broome on 6/4/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

struct ProductDetailView : View {
	@EnvironmentObject var userData: UserData
	var product: Product


	var body: some View {

		VStack(alignment: .leading) {
			HStack(alignment: .top) {
				Text(product.strain.name)
				Text(product.productType.rawValue)
			}
			HStack {
				VStack(alignment: .leading) {
					Text(product.strain.race.rawValue.capitalized)
						.color(Color.init(strainVariety: product.strain.race))
					Text(product.mass.description+" g")
				}
				Spacer()
				ProductImageViewCircular(product: product)
				.padding()
			}

			}
			.background(Color("InventoryBackgroundColor"))
			.scaledToFill()
	}

}

#if DEBUG
struct ProductDetailView_Previews : PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: UserData().products[0]).environmentObject(UserData())
    }
}
#endif
