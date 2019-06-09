//
//  ProductRow.swift
//  CannTrack
//
//  Created by Hugh Broome on 6/4/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

struct ProductRow : View {
	@EnvironmentObject var userData: UserData
	var product: Product

	@State private var showDetail = false

	var body: some View {
		HStack {

			ProductImageViewCircular(product: product)
				.padding(.all)
			VStack(alignment: .center) {
				Text(product.strain.name)
					.lineLimit(nil)

				HStack(alignment: .center) {
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
        ProductRow(product: inventory[0]).environmentObject(UserData())

    }
}

#endif
