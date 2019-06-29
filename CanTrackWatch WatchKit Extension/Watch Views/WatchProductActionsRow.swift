//
//  WatchProductActionsRow.swift
//  CanTrackWatch WatchKit Extension
//
//  Created by Hugh Broome on 6/29/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

struct WatchProductActionsRow : View {

	var product: Product


//	var buttons = [
//		("Dose", \)
//	]


    var body: some View {
		HStack(spacing: 8) {
//			ForEach(
			Text("Hi")
		}
    }

}

#if DEBUG
struct WatchProductActionsRow_Previews : PreviewProvider {
    static var previews: some View {
        WatchProductActionsRow(product: defaultProducts.products[1])
    }
}
#endif
