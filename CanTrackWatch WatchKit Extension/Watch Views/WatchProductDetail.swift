//
//  WatchProductDetail.swift
//  CanTrackWatch WatchKit Extension
//
//  Created by Hugh Broome on 6/28/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

struct WatchProductDetail : View {
	@EnvironmentObject var productStore: ProductStore

	@State private var isOpened: Bool = true

	var product: Product

	var productIndex: Int {
		productStore.products.firstIndex(where: { $0.id == product.id })!
	}

	private let dateFormatter: DateFormatter = {
		let dateFormatter2 = DateFormatter()
		dateFormatter2.timeZone = .current
		dateFormatter2.locale = .current
		dateFormatter2.calendar = .current
		dateFormatter2.dateFormat = "MMM d, yyy"
		return dateFormatter2
	}()



	var body: some View {
		HStack {
			VStack(alignment: .leading, spacing: 5) {
				HStack {
					Text(product.productType.rawValue)
						.lineLimit(nil)
					Button(action: {
						self.productStore.products[self.productIndex].isFavorite.toggle()
					}) {
						if self.productStore.products[self.productIndex].isFavorite {
							Image(systemName: "star.fill")
								.foregroundColor(Color.yellow)
						} else {
							Image(systemName: "star")
								.foregroundColor(Color.gray)
						}
					}
				}
				Text("Mass:"+" \(product.mass)g")
				isOpened ? Text("Opened: "+dateFormatter.string(from: product.dateOpened ?? Date()))
					.lineLimit(nil): Text("Unopened")
						.lineLimit(nil)
				Spacer()
				}
				.navigationBarTitle(Text(product.strain.name))
		}
	}
}

#if DEBUG
struct WatchProductDetail_Previews : PreviewProvider {
    static var previews: some View {
		WatchProductDetail(product: defaultProducts.products[0]).environmentObject(productStore)
    }
}
#endif
