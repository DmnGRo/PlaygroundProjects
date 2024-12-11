//
//  MarqueeText.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 10/12/2024.
//

import SwiftUI

struct MarqueeText<Content: View>: View {
    
    @Environment(\.colorScheme) var colorScheme
        
    var startingDelay: CGFloat = 0.0
    var spacing: CGFloat = 40
    var speed: CGFloat = 0.01
    
    @ViewBuilder let content: Content
    
    @State private var offset: CGFloat = 0
    @State private var textSize: CGSize = .zero
    @State private var widthAvailable: CGFloat = 0
    
    private var canAnimate: Bool {
        self.textSize.width > self.widthAvailable
    }
    
    private var repeatingTimes: Int {
        self.canAnimate ? 10 : 1
    }
    
    private var baseColor: Color {
         .black
    }
    
    private var colorMask: [Color] {
        [self.baseColor.opacity(0.3)] +
        (0...5).map { _ in self.baseColor } +
        [self.baseColor.opacity(0.3)]
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: self.spacing) {
                    ForEach(0..<self.repeatingTimes, id: \.self) { index in
                        self.content
                            .background {
                                GeometryReader { textGeometry in
                                    Color.clear
                                        .onAppear(perform: {
                                            self.textSize = textGeometry.size
                                        })
                                }
                            }
                    }
                    self.content
                }
                .offset(x: self.offset)
            }
            .mask(LinearGradient(colors: self.colorMask,
                                 startPoint: .leading,
                                 endPoint: .trailing))
            .disabled(true)
            .onAppear {
                self.widthAvailable = geometry.size.width
                DispatchQueue.main.asyncAfter(deadline: .now() + self.startingDelay) {
                    if self.canAnimate {
                        self.continuousAnimation()
                    }
                }
            }
        }.frame(height: self.textSize.height)
    }
    
    func continuousAnimation() {
        withAnimation(.linear(duration: self.speed * (self.textSize.width + self.spacing) * CGFloat(self.repeatingTimes))
            .repeatForever(autoreverses: false)) {
                self.offset = -(self.textSize.width * CGFloat(self.repeatingTimes))
            }
    }
}

#Preview {
    VStack {
        MarqueeText {
            Text("Hello, World!")
        }
        MarqueeText(startingDelay: 5){
            Text("Bright ideas spark growth, unlocking potential and inspiring limitless possibilities.")
        }
    }.padding(25)
        .background(.blue)
}
