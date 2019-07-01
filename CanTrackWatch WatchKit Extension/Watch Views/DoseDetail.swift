//
//  DoseDetail.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/30/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI
import Datez

struct DoseDetail : View {
	@EnvironmentObject var doseStore: DoseStore

	@State var dose: Dose

	@State private var priorDoseIsToday: Bool = false

	let navigationBarFormatter: DateFormatter = {
		var formatter = DateFormatter()
		formatter.timeZone = .current
		formatter.locale = .current
		formatter.calendar = .current
		formatter.timeStyle = .short
		formatter.dateStyle = .none
		formatter.dateFormat = "MMM d"
		return formatter
	}()

	let priorDoseTimeFormatter: DateFormatter = {
		var formatter = DateFormatter()
		formatter.timeZone = .current
		formatter.locale = .current
		formatter.calendar = .current
		formatter.timeStyle = .short
		formatter.dateStyle = .none
		return formatter
	}()

	var body: some View {
		VStack {
			Group {
				VStack(alignment: .leading) {
					VStack {
						HStack(alignment: .firstTextBaseline) {
							Text(dose.product.strain.name)
							Spacer()
							Text(dose.product.productType.rawValue)
							}
							.foregroundColor(Color(strainVariety: dose.product.strain.race))
						HStack(alignment: .firstTextBaseline) {
							Text("Route: ")
							Spacer()
							Text(dose.administrationRoute.rawValue)
							dose.viewBuilderImage
								.imageScale(.large)
								.foregroundColor(Color(strainVariety: dose.product.strain.race))
						}
					}

					VStack {
						HStack(alignment: .top) {
							Text("Prior Dose: ")
							Spacer()

							priorDoseIsToday ?
								Text(priorDoseTimeFormatter.string(from: (doseStore.getDosePrior(to: dose) ?? DoseStore.defaultDose).timestamp)) :
							nil
//								.truncationMode(.head)
						}
					}
				}
			}
			Spacer()
			Group {
				DoseActionsRow(dose: dose)
			}
			Spacer()
			}
			.navigationBarTitle(Text(navigationBarFormatter.string(from: dose.timestamp)))
	}
}

#if DEBUG

//struct DoseDetail_Previews : PreviewProvider {
//    static var previews: some View {
//		DoseDetail(dose: DoseStore.defaultDose).environmentObject(testData2["doses"] as! DoseStore)
//    }
//}
#endif