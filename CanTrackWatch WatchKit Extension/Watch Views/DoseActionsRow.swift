//
//  DoseActionsRow.swift
//  CanTrackWatch WatchKit Extension
//
//  Created by Hugh Broome on 7/1/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI


struct DoseActionsRow : View {

	@EnvironmentObject var doseStore: DoseStore

	var dose: Dose

	var buttons = DoseAction.allCases.compactMap { ($0.name, $0, $0.sfSymbol, $0.associatedColor) }

	var doseIndex: Int {
		doseStore.doses.firstIndex(where: {
			$0.id == dose.id
		})!
	}

    var body: some View {
		HStack(alignment: .bottom, spacing: 2) {
			ForEach(buttons.identified(by: \.0)) { value in
				Button(action: {
					switch value.1 {
					case .delete:
						DispatchQueue.main.async {
							self.doseStore.doses.remove(at: self.doseIndex)
						}
					case .edit:
						print("not implemented")
					case .redose:
						DispatchQueue.main.async {
							self.doseStore.doses.insert(Dose(product: self.dose.product, mass: 0.5, administrationRoute: self.dose.administrationRoute, doseTimestamp: Date()), at: 0)
						}
					}
				}) {
					DoseActionButton(doseAction: value.1)
				}
			}
		}
    }




}

struct DoseActionButton: View {

	var doseAction: DoseAction

	var body: some View {
		VStack(alignment: .center) {
			doseAction.sfSymbol
				.imageScale(.large)
			Text(doseAction.name)
				.font(.system(.footnote, design: .rounded))

		}
		.foregroundColor(doseAction.associatedColor)
	}
}
#if DEBUG
struct DoseActionsRow_Previews : PreviewProvider {
	static var previews: some View {
		DoseActionsRow(dose: DoseStore.defaultDose)
	}
}
struct DoseActionButton_Previews : PreviewProvider {
	static var previews: some View {
		DoseActionButton(doseAction: .redose)
	}
}
#endif
