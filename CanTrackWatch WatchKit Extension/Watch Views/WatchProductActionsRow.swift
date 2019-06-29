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


	var buttons = ProductActions.allCases.compactMap { ($0.name, $0) }


	var body: some View {
		HStack(spacing: 8) {
			ForEach(buttons.identified(by: \.0)) { value in
				Button(action: {

				}) {
					Text(value.0)
				}
			}
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
