//
//  MarqueeText.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 10/12/2024.
//

import SwiftUI

struct MarqueeText: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let text: String
    let font: UIFont
    var startingDelay: CGFloat = 0.0
    var spacing: CGFloat = 40
    var speed: CGFloat = 0.01
    
    @State private var offset: CGFloat = 0
    @State private var textSize: CGSize = .zero
    @State private var widthAvailable: CGFloat = 0
    
    private var canAnimate: Bool {
        self.textSize.width > self.widthAvailable
    }
    
    private var repeatingTimes: Int {
        self.canAnimate ? 10 : 1
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: self.spacing) {
                    ForEach(0..<self.repeatingTimes, id: \.self) { _ in
                        Text(self.text)
                            .font(Font(self.font))
                    }
                }
                .offset(x: self.offset)
            }
            .disabled(true)
            .onAppear {
                self.widthAvailable = geometry.size.width
                self.textSize = self.extractTextSize(self.text)
                DispatchQueue.main.asyncAfter(deadline: .now() + self.startingDelay) {
                    if self.canAnimate {
                        self.continuousAnimation()
                    }
                }
            }
        }.frame(height: self.textSize.height)
    }
    
    private var baseColor: Color {
        self.colorScheme == .dark ? .black : .white
    }
    
    private var decoration: some View {
        HStack {
            LinearGradient(colors: [.clear, .clear.opacity(0.3)],
                           startPoint: .leading,
                           endPoint: .trailing)
            
            .frame(width: 30)
            Spacer()
            LinearGradient(colors: [baseColor.opacity(0.3), baseColor],
                           startPoint: .leading,
                           endPoint: .trailing)
            .blendMode(.multiply)
            .frame(width: 30)
        }
    }
    
    func continuousAnimation() {
        withAnimation(.linear(duration: self.speed * (self.textSize.width + self.spacing) * CGFloat(self.repeatingTimes))
            .repeatForever(autoreverses: false)) {
                self.offset = -(self.textSize.width * CGFloat(self.repeatingTimes))
            }
    }
    
    func extractTextSize(_ text: String) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        return (text as NSString).size(withAttributes: attributes)
    }
}

#Preview {
    VStack {
        MarqueeText(text: "Hello, World!",
                    font: .systemFont(ofSize: 16))
        MarqueeText(text: "Bright ideas spark growth, unlocking potential and inspiring limitless possibilities.",
                    font: .systemFont(ofSize: 16),
                    startingDelay: 5)
    }.padding(25)
        .background(.blue)
}
