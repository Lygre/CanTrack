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

	#if !os(tvOS)
    var body: some View {
		NavigationView {
			List {
				ForEach(strainStore.strains.identified(by: \.identifiedValue)) { strain in
					Text(strain.name)
						.background(Color.blue)

				}
			}
				.scaledToFit()
				.listStyle(.grouped)
				.navigationBarTitle(Text("Strains"))
		}
    }
	#elseif os(tvOS)


	var body: some View {
		NavigationView {
			ScrollView {
				HStack {
					ForEach(strainStore.strains.identified(by: \.identifiedValue)) { strain in
						StrainCardView(strain: strain)
					}
				}

				}
				.navigationBarTitle(Text("Strains"))
				.focusable(true)
		}
	}

	#endif
}



struct StrainCardView : View {

	var strain: Strain
	#if os(tvOS)
	var body: some View {
		return VStack {
			Image(uiImage: #imageLiteral(resourceName: "cannaleaf"))
				.resizable()
				.clipShape(Circle())
				.aspectRatio(contentMode: .fill)
				.overlay(Circle().stroke(Color.black, lineWidth: 4))

			Text(strain.name)
				.lineLimit(nil)
			}
			.padding()
			.background(Color(strainVariety: strain.race))
			.clipShape(RoundedRectangle(cornerRadius: 8))
	}
	#endif

	#if !os(tvOS)
	var body: some View {
		return HStack {
			Image(uiImage: #imageLiteral(resourceName: "cannaleaf"))
				.resizable()
				.clipShape(Circle())
				.aspectRatio(contentMode: .fill)
				.overlay(Circle().stroke(Color.black, lineWidth: 4))

			Text(strain.name)
				.lineLimit(nil)
			}
			.padding()
			.background(Color(strainVariety: strain.race))
			.clipShape(RoundedRectangle(cornerRadius: 8))
	}
	#endif
}






#if DEBUG


struct StrainsView_Previews : PreviewProvider {
    static var previews: some View {
        StrainsView().environmentObject(store).environmentObject(strainStore)
    }
}
#endif

