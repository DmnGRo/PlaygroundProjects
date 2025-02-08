//
//  RandomPlaygroundView.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 27/12/2024.
//

import SwiftUI

struct RandomPlaygroundView: View {
    
    var body: some View {
        ZStack(alignment: .top) {
            // Linear Gradient Background
            LinearGradient(
                gradient: Gradient(colors: [.blue, .purple]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            // Scrollable List with Header
            
            VStack {
                Spacer()
                    .padding(.top, 200) // Adjust to match header height
                // Scrollable Content
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(1...50, id: \.self) { index in
                            Text("Item \(index)")
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.white.opacity(0.9))
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                    }
                }
                .background(Color.clear) // Transparent to show gradient
            }
            
            
            // Header
            Text("Header")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)

                .frame(height: 200) // Adjust height as needed
                .zIndex(1) // Ensure it stays on top
        }
    }
}
