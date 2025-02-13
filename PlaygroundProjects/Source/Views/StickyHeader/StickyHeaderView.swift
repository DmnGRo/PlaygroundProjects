//
//  StickyHeaderView.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 13/02/2025.
//

import SwiftUI

struct StickyHeaderView: View {
    @State private var verticalOffset: CGFloat = 0
    
    private let headerHeight: CGFloat = 350
    private let spacing: CGFloat = 8
    private let columnCount: Int = 2
    
    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { reader in
                ObserverScrollView(
                    onOffsetChanged: { offset in self.verticalOffset = -offset },
                    content: self.listView(
                        maxWidth: geometry.size.width,
                        resetScroll: {
                            if self.verticalOffset >= self.headerHeight {
                                reader.scrollTo("selector", anchor: .top)
                            }
                        }
                    ))
            }
        }
    }
    
    func listView(maxWidth: CGFloat, resetScroll: @escaping () -> Void = {}) -> some View {
        let tileSize = self.stationSize(width: maxWidth)
        return LazyVStack(alignment: .leading, spacing: 0, pinnedViews: [.sectionHeaders]) {
            ZStack{
                Text("Hello, World!")
            }
            .frame(width: maxWidth, height: self.headerHeight, alignment: .center)
            .id("header")
            
            Section(header: self.sectionHeaders(resetScroll: resetScroll)) {
                LazyVGrid(columns:  Array(repeating: GridItem(.flexible()), count: self.columnCount), spacing: 0) {
                    ForEach(0..<15, id: \.self) { index in
                        Text("Item \(index)")
                            .frame(width: tileSize, height: tileSize)
                            .background(RoundedRectangle(cornerRadius: 12).fill(.orange))
                            .id("item\(index)")
                            .padding(.vertical, 8)
                    }
                }
                .padding(.horizontal, 8)
            }
        }
    }
    
    func sectionHeaders(
        resetScroll: @escaping (() -> Void) = {}
    ) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<8, id: \.self) { index in
                    Text("Section \(index)")
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 50).fill(.black.opacity(0.3)))
                        .onTapGesture {
                            resetScroll()
                        }
                }
            }
            .padding(.horizontal, 10)
        }
        .scrollClipDisabled(true)
        .background(.green.opacity(self.verticalOffset >= self.headerHeight ? 1 : 0))
        .id("selector")
        .padding(.bottom, 16)
    }
    
    func stationSize(width: CGFloat) -> CGFloat {
        (width - 2 * self.spacing) / CGFloat(self.columnCount) - (CGFloat(self.columnCount) - 1) * self.spacing
    }
}

#Preview {
    StickyHeaderView()
}
