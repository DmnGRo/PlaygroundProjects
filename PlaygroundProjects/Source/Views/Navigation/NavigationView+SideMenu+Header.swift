//
//  NavigationView+SideMenu+Header.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 10/12/2024.
//

import SwiftUI

extension NavigationView.SideMenu {
    struct Header: View {
        
        let email: String
        let username: String

        private let layout: Layout = .init()
        
        var body: some View {
            HStack {
                Image(systemName: "person.circle.fill")
                    .imageScale(.large)
                    .foregroundStyle(.white)
                    .frame(width: self.layout.iconSize, height:  self.layout.iconSize)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.vertical)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(self.username)
                        .font(.subheadline)
                    
                    Text(self.email)
                        .font(.footnote)
                        .tint(.gray)
                }
            }
        }
    }
}

extension NavigationView.SideMenu.Header {
    private struct Layout {
        let iconSize: CGFloat = 48
    }
}

#Preview {
    NavigationView.SideMenu.Header(
        email: "some@email.com", username: "Some username"
    )
}
