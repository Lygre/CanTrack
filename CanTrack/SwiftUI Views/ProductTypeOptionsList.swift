//
//  ProductTypeOptionsList.swift
//  CannTrack
//
//  Created by Hugh Broome on 6/7/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

struct ProductTypeOptionsList : View {

	var product: Product

    var body: some View {


		List {
			ForEach(Product.ProductType.allCases.identified(by: \.hashValue)) { type in
				Text(type.rawValue)
			}
		}
    }
}

#if DEBUG
struct ProductTypeOptionsList_Previews : PreviewProvider {
    static var previews: some View {
		ProductTypeOptionsList(product: Product.defaultProduct)
    }
}
#endif
