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



let testDoseStore: DoseStore = DoseStore()

let testData2: [String: AnyObject] = [
	"strains": StrainStore(strains: [StrainStore.defaultStrain]),
	"products": defaultProducts,
	"doses": testDoseStore
]



struct ContentView : View {
	@EnvironmentObject var userData: UserData

	@State private var productStore: ProductStore = testData2["products"] as! ProductStore
	@State private var strainStore: StrainStore = testData2["strains"] as! StrainStore


	@State private var modalPresented: Bool = false



	var modal: Modal {
		Modal(ModalQuickDose(), onDismiss: {
			self.modalPresented.toggle()
		})

	}

	var body: some View {

		let longPress = LongPressGesture(minimumDuration: 1.0)
			.onEnded { _ in
				self.modalPresented.toggle()
		}


		return ScrollView {
			VStack(alignment: .launchScreenArrowAlignment, spacing: 10) {
				ProductImageViewCircular(product: productStore.products[1])
					.gesture(longPress)
					.alignmentGuide(.launchScreenArrowAlignment) { d in d[.trailing] / 2}

				HStack(alignment: .center, spacing: 5) {
					Spacer()
					Text("Dose")
					Spacer()
					Text("→")
						.alignmentGuide(.launchScreenArrowAlignment) { d in d[.trailing] / 2}
					Spacer()
					NavigationButton(destination:
						WatchProductsListView()
							.environmentObject(self.productStore)
							.environmentObject(self.strainStore)
							.environmentObject(userData)
					) {
						Image(systemName: "plus.circle")
							.imageScale(.large)
							.foregroundColor(Color.green)
					}
					}

				HStack(alignment: .center, spacing: 5) {
					Spacer()
					Text("Logs")
					Spacer()
					Text("→")
					.alignmentGuide(.launchScreenArrowAlignment) { d in d[.trailing] / 2}
					Spacer()
					NavigationButton(destination:
						WatchDailyDoseLog()
							.environmentObject(self.productStore)
							.environmentObject(self.strainStore)
							.environmentObject(userData)
					) {
						Image(systemName: "calendar")
							.imageScale(.large)
							.foregroundColor(Color("PerfectPurpleHaze"))
					}
					}
				Spacer()
			}
			.highPriorityGesture(longPress)
			}

			.background(Color("InventoryBackgroundColor"))
			.navigationBarTitle(Text("CanTrack"))

			.presentation(modalPresented ? modal : nil)

	}
}

#if DEBUG



struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
		ContentView().environmentObject(productStore).environmentObject(strainStore).environmentObject(testDoseStore)
    }
}
#endif

struct ModalQuickDose : View {
    var body: some View {
        return VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("Placeholder")
            }
        }
    }
}
