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

		VStack {
			HStack {
				Text(product.strain.name)
				Text(product.productType.rawValue)
			}
			Text(product.strain.race.rawValue.capitalized)
			.color(.yellow)
			Text(product.mass.description+" g")
		}
    }

}

//#if DEBUG
//struct ProductDetailView_Previews : PreviewProvider {
//    static var previews: some View {
//        ProductDetailView(product: )
//    }
//}
//#endif
