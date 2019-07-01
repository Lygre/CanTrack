//
//  ContentView.swift
//  CanTrackWatch WatchKit Extension
//
//  Created by Hugh Broome on 6/27/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI
import Datez

let testDate: Date = {
	var cmp = DateComponents()
	cmp.calendar = .current
	cmp.calendar?.locale = .current
	cmp.timeZone = .current
	cmp.year = 2019
	cmp.month = 6
	cmp.day = 29
	return cmp.isValidDate ? cmp.date! : Date()
}()



let testDoseStore: DoseStore = DoseStore(doses:
	[
		Dose(product: defaultProducts.products[0], mass: 0.3, administrationRoute: .inhalation, doseTimestamp: testDate),
		Dose(product: defaultProducts.products[0], mass: 0.3, administrationRoute: .inhalation, doseTimestamp: (testDate.gregorian.date)),
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
			VStack {

				ProductImageViewCircular(product: productStore.products[1])


				HStack(alignment: .center) {
					Spacer()
					Text("Dose")
					Spacer()
					Text("→")
						.alignmentGuide(.launchScreenArrowAlignment) { d in d[.bottom] }
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


				HStack {
					Spacer()
					Text("Logs")
					Spacer()
					Text("→")
						.alignmentGuide(.launchScreenArrowAlignment) { d in d[.bottom] / 2 }
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
					.alignmentGuide(.launchScreenArrowAlignment) { d in d[.bottom] / 2 }

				Spacer()

			}
			}
			.background(Color("InventoryBackgroundColor"))
		.navigationBarTitle(Text("CanTrack"))

	}
}

#if DEBUG



struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
		ContentView().environmentObject(productStore).environmentObject(strainStore).environmentObject(testDoseStore)
    }
}
#endif
