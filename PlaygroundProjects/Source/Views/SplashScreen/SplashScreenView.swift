//
//  SplashScreenView.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 14/02/2025.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var rotationAngle: Angle = .degrees(0)
    @State private var isVisible: Bool = false
    
    var body: some View {
        ZStack {
            Image(.app)
                .scaledToFit()
                .scaleEffect(2)
                .blur(radius: 100)
                .rotationEffect(self.rotationAngle)
                .onAppear {
                    withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
                        self.rotationAngle = .degrees(360)
                    }
                }
            
            VStack {
                Image(.app)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                Text("Playground App")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.accent)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation(.easeInOut) {
                                self.isVisible = true
                            }
                        }
                    }
                    .opacity(self.isVisible ? 1 : 0)
            }
            .shadow(radius: 10)
        }
    }
}

#Preview {
    SplashScreenView()
}
