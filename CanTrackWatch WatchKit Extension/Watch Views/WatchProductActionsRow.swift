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


	var buttons = ProductAction.allCases.compactMap { ($0.name, $0, $0.sfSymbol, $0.associatedColor) }


	var body: some View {
		HStack(spacing: 3) {
			ForEach(buttons.identified(by: \.0)) { value in
				Button(action: {

				}) {
					ProductActionButton(action: value.1)
						.foregroundColor(value.3)
				}
			}
		}
	}

}


struct ProductActionButton: View {

	var action: ProductAction

	var body: some View {
		VStack(alignment: .center) {
			action.sfSymbol
				.imageScale(.large)
			Text(action.name)
				.font(.footnote)
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
