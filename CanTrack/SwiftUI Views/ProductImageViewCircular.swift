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

	#if os(watchOS)
	var body: some View {
		Image(uiImage: product.productImage)
			.resizable()
			.clipShape(Circle())
			.overlay(Circle().stroke(Color.black, lineWidth: 2))
			.frame(width: 30, height: 30, alignment: .center)
    }


	#elseif !os(watchOS)
	var body: some View {

		Image(uiImage: product.productImage)
			.resizable()
			.clipShape(Circle())
			.overlay(Circle().stroke(Color.black, lineWidth: 2))
			.frame(width: 80, height: 80, alignment: .center)
	}


	#endif
}



//#if DEBUG
//struct ProductImageViewCircular_Previews : PreviewProvider {
//    static var previews: some View {
//		ProductImageViewCircular(product: inventory[0])
//    }
//}
//#endif
