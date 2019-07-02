//
//  WatchProductDetail.swift
//  CanTrackWatch WatchKit Extension
//
//  Created by Hugh Broome on 6/28/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

struct WatchProductDetail : View {
	@EnvironmentObject var userData: UserData

	@State private var isOpened: Bool = true

	var product: Product

	var productIndex: Int {
		userData.products.firstIndex(where: { $0.id == product.id })!
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
		HStack(alignment: .top) {
			VStack(alignment: .leading, spacing: 5) {
				HStack(alignment: .top) {
					Text(product.productType.rawValue)
						.lineLimit(nil)
					Spacer()
					Button(action: {
						withAnimation {
							self.userData.products[self.productIndex].isFavorite.toggle()
						}
					}) {
						if self.userData.products[self.productIndex].isFavorite {
							Image(systemName: "star.fill")
								.foregroundColor(Color.yellow)
						} else {
							Image(systemName: "star")
								.foregroundColor(Color.gray)
						}
					}
				}
				Text("Mass:"+" \(product.mass)g")
				isOpened ?
					Text("Opened: "+dateFormatter.string(from: product.dateOpened ?? Date()))
						.lineLimit(nil) :
					Text("Unopened")
						.lineLimit(nil)

				WatchProductActionsRow(product: product)
					.padding(.top)


				//This Spacer is to Push everything to the top; don't fuck with it
				Spacer()
				}
				.navigationBarTitle(Text(product.strain.name))
		}
	}
}

#if DEBUG
struct WatchProductDetail_Previews : PreviewProvider {
    static var previews: some View {
		WatchProductDetail(product: UserData().products[0]).environmentObject(UserData())
    }
}
#endif
