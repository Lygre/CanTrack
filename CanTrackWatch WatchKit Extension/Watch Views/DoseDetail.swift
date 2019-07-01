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

    var body: some View {
		VStack {
			Group {
				Section {
					Text("Helo")
				}
			}
		}
		.navigationBarTitle(Text())
    }
}

#if DEBUG
struct DoseDetail_Previews : PreviewProvider {
    static var previews: some View {
		DoseDetail(dose: <#Dose#>)
    }
}
#endif
