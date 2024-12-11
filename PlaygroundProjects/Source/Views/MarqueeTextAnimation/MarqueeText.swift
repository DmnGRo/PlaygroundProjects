//
//  MarqueeText.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 10/12/2024.
//

import SwiftUI

struct MarqueeText<Content: View>: View {
    
    var startingDelay: CGFloat = 0.0
    var speed: CGFloat = 50
    
    @ViewBuilder var content: Content
    
    @State private var contentSize: CGSize = .zero
    @State private var offset: CGFloat = .zero
    @State private var widthAvailable: CGFloat = .zero
    
    private let spacing: CGFloat = 40
    
    private var canAnimate: Bool {
        self.contentSize.width >= self.widthAvailable
    }
    
    private var colorMask: [Color] {
        [.clear] +
        (0...5).map { _ in .black } +
        [.clear]
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: self.spacing) {
                    content
                        .background {
                            GeometryReader { contentGeometry in
                                Color.clear
                                    .onAppear {
                                        DispatchQueue.main.async {
                                            self.contentSize = contentGeometry.size
                                            self.widthAvailable = geometry.size.width
                                            DispatchQueue.main.asyncAfter(deadline: .now() + self.startingDelay) {
                                                self.continuousAnimation()
                                            }
                                        }
                                    }
                                    .onChange(of: self.contentSize) { newSize in
                                        self.contentSize = newSize
                                        self.continuousAnimation()
                                    }
                            }
                        }
                    
                    if self.canAnimate {
                        ForEach((1...10), id: \.self) { _ in
                            content
                        }
                    }
                }
                .offset(x: self.offset)
            }
            .mask(LinearGradient(colors: self.colorMask,
                                 startPoint: .leading,
                                 endPoint: .trailing))
            .disabled(true)
        }
        .frame(height: self.contentSize.height)
        .clipped()
    }
    
    func continuousAnimation() {
        guard self.canAnimate else { return }
        let totalDistance = self.contentSize.width + self.spacing
        withAnimation(.linear(duration: (totalDistance / self.speed))
            .repeatForever(autoreverses: false)) {
                self.offset = -totalDistance
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
