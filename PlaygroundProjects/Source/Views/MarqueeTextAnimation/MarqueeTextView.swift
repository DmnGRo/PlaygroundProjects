//
//  MarqueeTextView.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 10/12/2024.
//

import SwiftUI

struct MarqueeTextView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.primaryBlue.gradient).ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20) {
                GeometryReader { geometry in
                    let size = geometry.size
                    Image(.NBC)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .frame(width: size.width, height: size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }.frame(height: 220)
                    .cornerRadius(10)
                MarqueeText(startingDelay: 0) {
                    Text("Bright ideas spark growth, unlocking potential and inspiring limitless possibilities.")
                }
                .padding(.horizontal, 15)
                .foregroundStyle(.white)
                
                Text("Bright ideas spark growth, unlocking potential and inspiring limitless possibilities.")
                    .marquee()
                Text("CKAY FEAT. AYRA STARR - COME CLOSE")
                    .marquee()
            }.padding()
        }
    }
}

#Preview {
    MarqueeTextView()
}
