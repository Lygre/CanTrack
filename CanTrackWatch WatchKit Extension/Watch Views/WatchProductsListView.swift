//
//  WatchProductsListView.swift
//  CanTrackWatch WatchKit Extension
//
//  Created by Hugh Broome on 6/28/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

struct WatchProductsListView : View {
	@EnvironmentObject var productStore: ProductStore
	@EnvironmentObject var strainStore: StrainStore



	var body: some View {
		ScrollView {
			ForEach(productStore.products.identified(by: \.id)) { product in
				NavigationButton(destination: EmptyView()) {
					VStack(alignment: .leading) {
						WatchProductRow(product: product)
					}
				}
			}
		}
	}
}

#if DEBUG
struct WatchProductsListView_Previews : PreviewProvider {
    static var previews: some View {
        WatchProductsListView().environmentObject(defaultProducts).environmentObject(strainStore)
    }
}
#endif
