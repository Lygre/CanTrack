//
//  StrainsView.swift
//  CannTrack
//
//  Created by Hugh Broome on 6/6/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI



struct StrainsView : View {
	@EnvironmentObject var userData: UserData

    var body: some View {
			List {
				ForEach(self.userData.strains.identified(by: \.id)) { strain in
					Text(strain.name)
						.background(Color.blue)

				}
			}
    }
}

#if DEBUG
struct StrainsView_Previews : PreviewProvider {
    static var previews: some View {
        StrainsView().environmentObject(UserData())
    }
}
#endif
