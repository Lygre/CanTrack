//
//  WatchProductDetail.swift
//  CanTrackWatch WatchKit Extension
//
//  Created by Hugh Broome on 6/28/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

struct WatchProductDetail : View {

	var product: Product

	private let dateFormatter: DateFormatter = {
		let dateFormatter2 = DateFormatter()
		dateFormatter2.timeZone = .current
		dateFormatter2.locale = .current
		dateFormatter2.calendar = .current
		dateFormatter2.dateFormat = "MMM d, yyy"
		return dateFormatter2
	}()

	@State private var isOpened: Bool = false

    var body: some View {
		VStack {
			Text(product.mass+"g")
			isOpened ? Text(dateFormatter.string(from: product.dateOpened ?? Date())) : Text("Unopened")
		}
    }
}

#if DEBUG
struct WatchProductDetail_Previews : PreviewProvider {
    static var previews: some View {
		WatchProductDetail(product: defaultProducts.products[0])
    }
}
#endif
