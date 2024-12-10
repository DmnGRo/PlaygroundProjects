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
                        .frame(width: size.width, height: size.height)
                }.frame(height: 220)
                MarqueeText(text: "Bright ideas spark growth, unlocking potential and inspiring limitless possibilities.",
                            font: .systemFont(ofSize: 16))
                .foregroundStyle(.white)
            }.padding()
        }
    }
}

#Preview {
    MarqueeTextView()
}
