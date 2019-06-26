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
		NavigationView {
			List {
				ForEach(strainStore.strains.identified(by: \.identifiedValue)) { strain in
					Text(strain.name)
						.background(Color.blue)

				}
			}
			.navigationBarTitle(Text("Strains"))
		}
    }
}

#if DEBUG


struct StrainsView_Previews : PreviewProvider {
    static var previews: some View {
        StrainsView().environmentObject(store).environmentObject(strainStore)
    }
}
#endif
