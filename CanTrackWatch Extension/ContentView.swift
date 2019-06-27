//
//  ContentView.swift
//  CanTrackWatch Extension
//
//  Created by Hugh Broome on 6/26/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

private var pStore: ProductStore = ProductStore(products: defaultProducts.products)
private var sStore: StrainStore = StrainStore(strains: defaultProducts.products.compactMap({ return $0.strain }))


struct ContentView : View {
    var body: some View {
        Text("Hello World")
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
