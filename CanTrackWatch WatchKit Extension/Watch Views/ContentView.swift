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



//let testDoseStore: DoseStore = DoseStore(doses:
//	[
//		Dose(product: defaultProducts.products[0], mass: 0.3, administrationRoute: .inhalation, doseTimestamp: testDate),
//		Dose(product: defaultProducts.products[0], mass: 0.3, administrationRoute: .inhalation, doseTimestamp: (testDate.gregorian.date)),
//		Dose(product: defaultProducts.products[1], mass: 0.7, administrationRoute: .oral)
//	])

let testData2: [String: AnyObject] = [
	"strains": StrainStore(strains: [StrainStore.defaultStrain]),
	"products": defaultProducts
]



struct ContentView : View {

	var userData: UserData = UserData()

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
				ProductImageViewCircular(product: userData.products[1])
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
							.environmentObject(self.strainStore)
							.environmentObject(self.userData)
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
							.environmentObject(self.strainStore)
							.environmentObject(self.userData)
					) {
						Image(systemName: "calendar")
							.imageScale(.large)
							.foregroundColor(Color("PerfectPurpleHaze"))
					}
					}
				Spacer()
			}
			}.background(Color("InventoryBackgroundColor"))
			.navigationBarTitle(Text("CanTrack"))

			.presentation(modalPresented ? modal : nil)

	}
}

#if DEBUG



struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
		ContentView()
			.environmentObject(strainStore)
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
