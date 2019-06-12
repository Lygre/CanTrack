//
//  ContextMenu.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/11/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import SwiftUI

let menuList: UIMenu<UIAction> = {

	let rename = UIAction(__title: "Rename Pupper", image: UIImage(systemName: "square.and.pencil"), options: []) { action in
		// Show rename UI
	}

	// Here we specify the "destructive" option to show that it’s destructive in nature
	let delete = UIAction(__title: "Delete Photo", image: UIImage(systemName: "trash"), options: .destructive) { action in
		// Delete this photo 😢
	}

	// The "title" will show up as an action for opening this menu
	let edit = UIMenu<UIAction>.create(title: "Edit...", children: [rename, delete])

	let share = UIAction(__title: "Rename Pupper", image: UIImage(systemName: "square.and.pencil"), options: []) { action in
		// Show rename UI
	}

	// Create our menu with both the edit menu and the share action
	return UIMenu<UIAction>.create(title: "Main Menu", children: [edit, share])

}()




func makeContextMenu() -> UIMenu<UIAction> {

	let rename = UIAction(__title: "Rename Pupper", image: UIImage(systemName: "square.and.pencil"), options: []) { action in
		// Show rename UI
	}

	// Here we specify the "destructive" option to show that it’s destructive in nature
	let delete = UIAction(__title: "Delete Photo", image: UIImage(systemName: "trash"), options: .destructive) { action in
		// Delete this photo 😢
	}

	// The "title" will show up as an action for opening this menu
	let edit = UIMenu<UIAction>.create(title: "Edit...", children: [rename, delete])

	let share = UIAction(__title: "Rename Pupper", image: UIImage(systemName: "square.and.pencil"), options: []) { action in
		// Show rename UI
	}

	// Create our menu with both the edit menu and the share action
	return UIMenu<UIAction>.create(title: "Main Menu", children: [edit, share])
}

struct ContextMenu : View {

    var body: some View {
		List {
			Text("Hi")
			Text("Hi")
			Text("Hi")
			Text("Hi")
			Text("Hi")
		}
    }


}

#if DEBUG
struct ContextMenu_Previews : PreviewProvider {
    static var previews: some View {
        ContextMenu()
    }
}
#endif
