//
//  CollapsingHeaderView.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 10/12/2024.
//

import SwiftUI

struct CollapsingHeaderView: View {
    let size: CGSize
    let safeArea: EdgeInsets
    
    @State private var scrollOffset: CGFloat = .zero
    
    private var layout: Layout {
        .init(safeAreaTop: self.safeArea.top)
    }
    
    private var progress: CGFloat {
        self.layout.calcProgress(offset: self.scrollOffset)
    }
    
    private var headerHeight: CGFloat {
        self.layout.calcHeaderHeight(offset: self.scrollOffset)
    }
    
    var body: some View {
        ScrollViewReader { scrollReader in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    self.headerView()
                        .zIndex(100)
                    self.loadingStateCards()
                }
                .id("CollapsingHeaderView")
                .background {
                    ScrollDetector(onScroll: { offset in
                        self.scrollOffset = -offset
                    }, onDragEnded: { offset , velocity in
                        // Snap effect
                        let targetEnd = offset + (velocity * 124)
                        if (0...self.layout.scrollRange).contains(targetEnd) {
                            withAnimation(.interactiveSpring(response: 0.55,
                                                             dampingFraction: 0.65,
                                                             blendDuration: 0.65)) {
                                scrollReader.scrollTo("CollapsingHeaderView", anchor: .top)
                            }
                        }
                    })
                }
            }
            .ignoresSafeArea()
        }
    }
    
    // HEADER
    @ViewBuilder
    func headerView() -> some View {
        GeometryReader { proxy in
            ZStack {
                Rectangle()
                    .fill(.primaryBlue.gradient)
                VStack(spacing: 15) {
                    GeometryReader { geometry in
                        let rect = geometry.frame(in: .global)
                        Image(.NBC)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: rect.width, height: rect.height)
                            .cornerRadius(12)
                            .scaleEffect(1 - (self.progress * 0.5), anchor: .leading)
                            .offset(x: self.resizedOffsetX(of: rect),
                                    y: self.resizedOffsetY(of: rect))
                    }.frame(width: self.layout.maxImageWidth, height: self.layout.maxImageWidth)
                    Text("NBC")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .scaleEffect(1 - (self.progress * 0.15))
                        .offset(x: -125 * self.progress,
                                y: -60 * self.progress)
                        .opacity((1 - self.progress))
                }
            }
            .frame(width: self.size.width,
                   height: self.headerHeight,
                   alignment: .top)
            .offset(y: -self.scrollOffset)
        }.frame(height: self.layout.maxHeaderHeight)
    }
    
    private func resizedOffsetY(of rect: CGRect) -> CGFloat {
        let size = rect.minY - self.layout.bottomPadding * 2
        return -size * self.progress
    }
    
    private func resizedOffsetX(of rect: CGRect) -> CGFloat {
        -(rect.minX - self.layout.bottomPadding) * self.progress
    }
    
    // LOADING STATE CARDS
    @ViewBuilder
    func loadingStateCards() -> some View {
        VStack(spacing: 15){
            ForEach(1...25, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.black.opacity(0.05))
                    .frame(height: 77)
            }
        }.padding(15)
    }
}

extension CollapsingHeaderView {
    struct Layout {
        let safeAreaTop: CGFloat
        
        let bottomPadding: CGFloat = 15
        
        let minImageWidth: CGFloat = 80
        
        let maxImageWidth: CGFloat = 160
        
        var minHeaderHeight: CGFloat {
            118 + self.safeAreaTop
        }
        
        var maxHeaderHeight: CGFloat {
            300 + self.safeAreaTop
        }
        
        var scrollRange: CGFloat {
            self.maxHeaderHeight - self.minHeaderHeight
        }
        
        func calcProgress(offset: CGFloat) -> CGFloat {
            (-offset / self.scrollRange).clamped(0, 1)
        }
        
        func calcHeaderHeight(offset: CGFloat) -> CGFloat {
            self.maxHeaderHeight + offset < self.minHeaderHeight ?
            self.minHeaderHeight:
            self.maxHeaderHeight + offset
        }
        
    }
}

#Preview {
    GeometryReader { proxy in
        CollapsingHeaderView(size: proxy.size,
                 safeArea: proxy.safeAreaInsets)
    }
}
