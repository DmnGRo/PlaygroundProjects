//
//  MarqueeText.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 10/12/2024.
//

import SwiftUI

struct MarqueeText: View {
    
    var text: String
    var font: Font
    var spacing: CGFloat = 40
    
    @State private var contentSize: CGSize = .zero
    @State private var animate: Bool = false
    
    private var fullContentWidth: CGFloat {
        return -(self.contentSize.width)
    }
    
    private var animation: Animation {
        print("[App-debug] animation with contentSize: \(self.contentSize.width)")
        return Animation
            .linear(duration: Double(self.contentSize.width) * 0.02)
            .repeatForever(autoreverses: false)
    }
    
    private var defaultAnimation: Animation {
        Animation
            .linear(duration: 0)
    }
    
    var body: some View {
        self.content
            .hidden()
            .overlay {
                GeometryReader { containerProxy in
                    self.content
                        .fixedSize(horizontal: true, vertical: false)
                        .hidden()
                        .overlay {
                            GeometryReader { contentProxy in
                                let contentSize = contentProxy.size
                                HStack(spacing: self.spacing) {
                                    self.content
                                    self.content
                                }.frame(width: contentSize.width * 2 + self.spacing)
                                    .offset(x: self.animate ? -(contentSize.width + self.spacing) : 0)
                                    .animation(
                                        self.animate ? self.animation : self.defaultAnimation,
                                        value: self.animate
                                    )
                                    .onAppear {
                                        print("[App-debug] onAppear")
//                                        self.contentSize = contentSize
//                                        self.animate = containerProxy.size.width < contentSize.width
                                        self.animate = true
                                    }
                                    .onChange(of: contentProxy.size) { newSize in
                                            print("[App-debug] onChange: \(newSize)")
                                        
                                        self.animate = containerProxy.size.width < newSize.width
                                        self.contentSize = newSize
                                    }
                                    .onDisappear {
                                        print("[App-debug] onDisappear")
                                    }
                            }
                        }
                }
            }
            .clipped()
    }
    
    private func startAnimation(_ contentWidth: CGFloat) -> Animation {
        
            print("[App-debug] animation with contentSize: \(self.contentSize.width)")
        return Animation
            .linear(duration: Double(contentWidth) / 30)
            .repeatForever(autoreverses: false)
    }
    
    private var content: Text {
        Text(self.text)
            .font(self.font)
    }
}

#Preview {
    
    @Previewable @State var text: String = "Another text This is a brand new message that forces an animation reset."
    @Previewable @State var currentText: String = "Bright ideas spark growth, unlocking potential and inspiring limitless possibilities."
    
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
    }.padding(25)
        .background(.blue)
}
