//
//  DoseDetail.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/30/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

struct DoseDetail : View {

	@State var dose: Dose

	let navigationBarFormatter: DateFormatter = {
		var formatter = DateFormatter()
		formatter.timeZone = .current
		formatter.locale = .current
		formatter.calendar = .current
		formatter.timeStyle = .short
		formatter.dateStyle = .short
		return formatter
	}()

    var body: some View {
		VStack {
			Group {
				Section {
					VStack(alignment: .leading) {
						HStack(alignment: .top) {
							Text(dose.product.strain.name)
							Text(dose.product.productType.rawValue)
						}
						HStack {
							Text("Hi")
							dose.viewBuilderImage
						}

					}

				}
				}.foregroundColor(Color.white)
			Spacer()
			}
		.navigationBarTitle(Text(navigationBarFormatter.string(from: dose.timestamp)))
    }
}

#if DEBUG
struct DoseDetail_Previews : PreviewProvider {
    static var previews: some View {
		DoseDetail(dose: DoseStore.defaultDose)
    }
}
#endif
