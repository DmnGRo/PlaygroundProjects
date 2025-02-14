//
//  NavigationView+SideMenu+Row.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 10/12/2024.
//

import SwiftUI

extension NavigationView.SideMenu {
    struct Row: View {
        
        let menu: SideMenuOption
        
        @Binding var selectdOption: SideMenuOption
        
        private var isSelected: Bool {
            self.selectdOption == self.menu
        }
        
        var body: some View {
            HStack {
                Image(systemName: self.menu.image)
                    .imageScale(.small)
                
                Text(self.menu.title)
                    .font(.subheadline)
                
                Spacer()
            }
            .padding(.leading)
            .foregroundStyle(isSelected ? .blue : .secondary)
            .frame(height: 44)
            .background(isSelected ? .blue.opacity(0.2) : Color.clear)
            .clipped()
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        NavigationView.SideMenu.Row(menu: SideMenuOption.marqueeTextEffect,
                                    selectdOption: .constant(SideMenuOption.marqueeTextEffect))
        
        NavigationView.SideMenu.Row(menu: SideMenuOption.marqueeTextEffect,
                                    selectdOption: .constant(SideMenuOption.collapsingHeader))
    }
}
