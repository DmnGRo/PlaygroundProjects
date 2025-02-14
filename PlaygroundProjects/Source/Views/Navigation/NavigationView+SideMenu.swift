//
//  NavigationView+SideMenu.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 10/12/2024.
//

import SwiftUI
import SwiftUICore

extension NavigationView {
    struct SideMenu: View {
        @Binding var isShowing: Bool
        @Binding var selectedOption: SideMenuOption
        
        let email: String
        let username: String
        let version: String
        
        var body: some View {
            ZStack {
                if self.isShowing {
                    Rectangle()
                        .opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture { self.isShowing.toggle() }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 32) {
                            NavigationView.SideMenu.Header(email: self.email,
                                                           username: self.username)
                            
                            Section {
                                VStack {
                                    ForEach(SideMenuOption.allCases) { option in
                                        Button(action: { self.onOptionTap(option: option) }) {
                                            NavigationView.SideMenu.Row(menu: option,
                                                                        selectdOption: self.$selectedOption)
                                        }.buttonStyle(.plain)
                                    }
                                }
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                            
                            Spacer()
                            
                            Section {
                                NavigationView.SideMenu.InfoSection(
                                    version: self.version)
                            }
                            .padding(16)
                            .frame(width: 240)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                        }
                        .padding()
                        .frame(width: 270, alignment: .leading)
                        .background(.white)
                        Spacer()
                    }
                    .transition(.move(edge: .leading))
                }
            }
            .animation(.easeInOut, value: self.isShowing)
        }
        
        private func onOptionTap(option: SideMenuOption) {
            self.selectedOption = option
            self.isShowing = false
        }
    }
}

#Preview {
    NavigationView.SideMenu(isShowing: .constant(true),
                            selectedOption: .constant(.collapsingHeader),
                            email: "example@example.com",
                            username: "example",
                            version: "1.0.0")
}
