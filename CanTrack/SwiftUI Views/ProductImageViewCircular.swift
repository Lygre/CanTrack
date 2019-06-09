//
//  ProductImageViewCircular.swift
//  CannTrack
//
//  Created by Hugh Broome on 6/5/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

struct ProductImageViewCircular : View {

	var product: Product

	var body: some View {

		Image(uiImage: product.productImage)

			.resizable()
		.clipShape(Circle())
		.overlay(Circle().stroke(Color.black, lineWidth: 4))
			.frame(width: 50, height: 50, alignment: .bottomTrailing)
    }
}

//#if DEBUG
//struct ProductImageViewCircular_Previews : PreviewProvider {
//    static var previews: some View {
//		ProductImageViewCircular(product: inventory[0])
//    }
//}
//#endif
