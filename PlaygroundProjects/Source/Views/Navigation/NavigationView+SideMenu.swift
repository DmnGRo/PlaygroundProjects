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
        
        var body: some View {
            ZStack {
                if self.isShowing {
                    Rectangle()
                        .opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture { self.isShowing.toggle() }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 32) {
                            NavigationView.SideMenu.Header()
                            
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
                            selectedOption: .constant(.collapsingHeader))
}
