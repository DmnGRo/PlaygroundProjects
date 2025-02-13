//
//  CollapsingHeaderViewV2.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 19/12/2024.
//

import SwiftUI
import SwiftUICore
import Foundation

struct CollapsingHeaderViewV2: View {
    
    @State private var verticalOffset: CGFloat = .zero
    
    private let layout: Layout = .init()
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.red]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .ignoresSafeArea()
                
                ScrollViewReader { reader in
                    ObserverScrollView(onOffsetChanged: { offset in self.verticalOffset = offset },
                                       onDragEnded: { self.onDragEnded(reader) },
                                       content: self.layoutCards(proxy: proxy))
                }
                
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.red]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .mask {
                    VStack {
                        Rectangle()
                            .frame(height: self.headerHeight +  proxy.safeAreaInsets.top, alignment: .top)
                            .foregroundColor(.black)
                        Rectangle()
                            .foregroundColor(.black.opacity(0))
                    }
                    .ignoresSafeArea()
                }
                .drawingGroup()
                .ignoresSafeArea()
                .allowsHitTesting(false)
                
                self.headerView(size: proxy.size)
                    .zIndex(1)
                    .frame(height: self.headerHeight)
            }
        }
    }
    
    private func headerView(size: CGSize) -> some View {
        GeometryReader { proxy in
            VStack {
                GeometryReader { geometry in
                    let rect = geometry.frame(in: .global)
                    Image(.NBC)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: rect.width, height: rect.height)
                        .cornerRadius(12)
                }.frame(width: self.imageSize,
                        height: self.imageSize)
                
                Text("NBC")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .frame(width: size.width,
                   alignment: .top)
        }
    }
    
    private func layoutCards(proxy: GeometryProxy) -> some View {
        LazyVStack(spacing: 8) {
            ForEach((1...50), id: \.self) { index in
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.primaryBlue.opacity(0.3))
                        .frame(height: 80)
                    Text("Item \(index)")
                        .foregroundStyle(.accent)
                }
                .padding(.top, index == 1 ? 8 : 0)
            }
            .padding(.horizontal, 8)
        }.padding(.top, self.layout.headerHeightExpanded)
    }
    
    private func onDragEnded(_ reader: ScrollViewProxy) {
        withAnimation(.spring(duration: 0.3)) {
            let offset = -self.verticalOffset
            print("onDragEnded: \(offset)")
            if (0...(scrollRange/2)).contains(offset) {
                print("top half height: \(offset)")
                self.verticalOffset = scrollRange/2
                reader.scrollTo(0, anchor: .top)
            } else if (scrollRange/2...scrollRange).contains(offset) {
                print("bottom half height: \(offset)")
                self.verticalOffset = .zero
                reader.scrollTo(0, anchor: .top)
            }
        }
    }
}

extension CollapsingHeaderViewV2 {
    private var headerHeight: CGFloat {
        (self.layout.headerHeightExpanded + self.verticalOffset)
            .clamped(self.layout.headerHeightColapsed, self.layout.headerHeightExpanded)
    }
    
    private var imageSize: CGFloat {
        (self.layout.imageSizeExpanded * (1 - self.progress))
            .clamped(self.layout.imageSizeColapsed, self.layout.imageSizeExpanded)
    }
    
    private var progress: CGFloat {
        -(self.verticalOffset / self.scrollRange)
    }
    
    private var scrollRange: CGFloat {
        self.layout.headerHeightExpanded - self.layout.headerHeightColapsed
    }
}

extension CollapsingHeaderViewV2 {
    struct Layout {
        let imageSizeExpanded: CGFloat = 160
        let imageSizeColapsed: CGFloat = 80
        
        let headerHeightExpanded: CGFloat = 300
        let headerHeightColapsed: CGFloat = 120
    }
}

#Preview {
    CollapsingHeaderViewV2()
}
