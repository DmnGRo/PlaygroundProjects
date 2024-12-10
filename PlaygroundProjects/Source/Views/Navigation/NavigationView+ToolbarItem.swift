//
//  NavigationView+ToolbarItem.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 10/12/2024.
//

import SwiftUI
import SwiftUICore

extension NavigationView {
    struct Toolbar: ToolbarContent {
        
        @Binding var showMenu: Bool
        let placement: ToolbarItemPlacement
        
        var body: some ToolbarContent {
            ToolbarItem(placement: self.placement) {
                Button(action: {
                    self.showMenu.toggle()
                }) {
                    Image(systemName: "line.3.horizontal")
                }
            }
        }
    }
}
