//
//  ContentView.swift
//  CanTrackWatch WatchKit Extension
//
//  Created by Hugh Broome on 6/27/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

let testDate: Date = {
	var cmp = DateComponents()
	cmp.calendar = .current
	cmp.calendar?.locale = .current
	cmp.timeZone = .current
	cmp.year = 2019
	cmp.month = 1
	cmp.day = 1
	return cmp.isValidDate ? cmp.date! : Date()
}()

let testDoseStore: DoseStore = DoseStore(doses:
	[
		Dose(product: defaultProducts.products[0], mass: 0.3, administrationRoute: .inhalation, doseTimestamp: testDate),
		Dose(product: defaultProducts.products[1], mass: 0.7, administrationRoute: .oral)
	])

let testData2: [String: AnyObject] = [
	"strains": StrainStore(strains: [StrainStore.defaultStrain]),
	"products": defaultProducts,
	"doses": testDoseStore
]



struct ContentView : View {

	@State private var productStore: ProductStore = testData2["products"] as! ProductStore
	@State private var strainStore: StrainStore = testData2["strains"] as! StrainStore
	@State private var doseStore: DoseStore = testData2["doses"] as! DoseStore

	var body: some View {
		ScrollView {
			VStack(alignment: .launchScreenArrowAlignment) {
				HStack(alignment: .center) {
					ProductImageViewCircular(product: productStore.products[1])
					Text("CanTrack")
						.font(.custom("Awesome", size: 25))
						.color(Color("KindCrapGreen"))
						.lineLimit(nil)
					}
					.padding(.all)
					.alignmentGuide(.launchScreenArrowAlignment) { d in d[.lastTextBaseline] / 2 }

				HStack(alignment: .center) {
					Text("Dose")
					Spacer()
					Text("→")
						.alignmentGuide(.launchScreenArrowAlignment) { d in d[.top] / 2 }
					Spacer()
					NavigationButton(destination:
						WatchProductsListView()
							.environmentObject(self.productStore)
							.environmentObject(self.strainStore)
							.environmentObject(self.doseStore)
					) {
						Image(systemName: "plus.circle")
							.imageScale(.large)
							.foregroundColor(Color.green)
					}

					}
					.padding()
					.alignmentGuide(.launchScreenArrowAlignment) { d in d[.firstTextBaseline] / 2 }

				HStack(alignment: .center) {
					Text("Logs")
					Spacer()
					Text("→")
						.alignmentGuide(.launchScreenArrowAlignment) { d in d[.top] / 2 }
					Spacer()
					NavigationButton(destination:
						WatchDailyDoseLog()
							.environmentObject(self.productStore)
							.environmentObject(self.strainStore)
							.environmentObject(self.doseStore)
					) {
						Image(systemName: "calendar")
							.imageScale(.large)
							.foregroundColor(Color("PerfectPurpleHaze"))
					}
					}
					.padding()
					.alignmentGuide(.launchScreenArrowAlignment) { d in d[.firstTextBaseline] / 2 }

				Spacer()

			}
			}
			.background(Color("InventoryBackgroundColor"))

	}
}

#if DEBUG



struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
		ContentView().environmentObject(productStore).environmentObject(strainStore).environmentObject(testDoseStore)
    }
}
#endif
