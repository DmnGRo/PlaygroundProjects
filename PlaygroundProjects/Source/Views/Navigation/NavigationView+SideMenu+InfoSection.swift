//
//  NavigationView+SideMenu+InfoSection.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 14/02/2025.
//

import SwiftUI

extension NavigationView.SideMenu {
    struct InfoSection: View {
        let version: String
        
        var body: some View {
            VStack {
                Text("App Version: \(self.version)")
                    .font(.footnote)
                    .foregroundStyle(.primaryBlue)
            }
        }
    }
}
