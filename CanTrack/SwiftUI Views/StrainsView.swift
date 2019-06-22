//
//  StrainsView.swift
//  CannTrack
//
//  Created by Hugh Broome on 6/6/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI



struct StrainsView : View {
//	@EnvironmentObject var userData: UserData
	@EnvironmentObject var productStore: ProductStore
	@EnvironmentObject var strainStore: StrainStore


    var body: some View {
			List {
				ForEach(strainStore.strains.identified(by: \.identifiedValue)) { strain in
					Text(strain.name)
						.background(Color.blue)

				}
			}
    }
}

#if DEBUG

let strainStore = StrainStore(strains: testData.compactMap({ $0.strain }))

struct StrainsView_Previews : PreviewProvider {
    static var previews: some View {
        StrainsView().environmentObject(userData).environmentObject(store).environmentObject(strainStore)
    }
}
#endif
