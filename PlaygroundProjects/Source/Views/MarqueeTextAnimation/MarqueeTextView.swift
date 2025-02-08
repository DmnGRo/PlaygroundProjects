//
//  MarqueeTextView.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 10/12/2024.
//

import SwiftUI

struct MarqueeTextView: View {
    
    @State var text: String = "Another text This is a brand new message that forces an animation reset."
    @State var currentText: String = "Bright ideas spark growth, unlocking potential and inspiring limitless possibilities."
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(.primaryBlue.gradient)
                    .ignoresSafeArea()
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
                    
                    MarqueeText(text: "Bright ideas spark growth, unlocking potential and inspiring limitless possibilities.",
                                font: .callout)
                    .padding(.horizontal, 15)
                    .foregroundStyle(.white)
                    
                    Text("Bright ideas spark growth, unlocking potential and inspiring limitless possibilities.")
                        .marquee()
                    Text("CKAY FEAT. AYRA STARR - COME CLOSE")
                        .marquee()
                }.padding()
                
                VStack {
                    Button(action: {
                        currentText = text
                    }) {
                        Text("Update")
                            .padding()
                            .background(.red)
                            .cornerRadius(10)
                    }
                    MarqueeText(text: "Hello, World!",
                                font: .largeTitle)
                    .foregroundStyle(.white)
                    MarqueeText(text: currentText,
                                font: .callout)
                    .foregroundStyle(.white)
                }
            }
        }
    }
}

#Preview {
    MarqueeTextView()
}
