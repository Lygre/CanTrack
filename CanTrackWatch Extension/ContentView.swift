//
//  ContentView.swift
//  CanTrackWatch Extension
//
//  Created by Hugh Broome on 6/26/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

struct ContentView : View {

	@EnvironmentObject var productStore: ProductStore
	@EnvironmentObject var strainStore: StrainStore

    var body: some View {
		HStack {
			Text(productStore.products[0].productType.rawValue)
			ProductImageViewCircular(product: productStore.products[0])
		}
    }


}

#if DEBUG

private var productStore: ProductStore = ProductStore(products: defaultProducts.products)
private var strainStore: StrainStore = StrainStore(strains: defaultProducts.products.compactMap({ return $0.strain }))



struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(productStore).environmentObject(strainStore)

    }
}
#endif
