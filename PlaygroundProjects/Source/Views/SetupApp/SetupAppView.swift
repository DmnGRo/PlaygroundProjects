//
//  SetupAppView.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 14/02/2025.
//

import SwiftUI

struct SetupAppView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Color.blue.edgesIgnoringSafeArea(.all)
            Text("Please setup the email and password in the settings screen")
                .padding(.horizontal, 24)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    SetupAppView()
}
