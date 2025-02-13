//
//  FlowRowLayoutView.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 12/02/2025.
//

import SwiftUI

struct FlowRowLayoutView: View {
    
    @State private var tags: [String] = [
        "#Coding",
        "#Programming",
        "#DevLife",
        "#CodeNewbie",
        "#100DaysOfCode",
        "#SoftwareDevelopment",
        "#CleanCode",
        "#OpenSource",
        "#WebDevelopment",
        "#WebDev",
        "#Frontend",
        "#Backend",
        "#FullStack",
        "#HTML",
        "#CSS",
        "#JavaScript",
        "#ReactJS",
        "#NodeJS",
        "#NextJS",
        "#MobileDevelopment",
        "#MobileDev",
        "#iOSDevelopment",
        "#AndroidDev",
        "#Swift",
        "#Kotlin",
        "#Flutter",
        "#ReactNative"
    ]
    @State private var selectedTags: [String] = []
    @Namespace private var animation
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(self.selectedTags, id: \.self) { tag in
                        TagView(tag, .pink, "checkmark")
                            .matchedGeometryEffect(id: tag, in: self.animation)
                            .onTapGesture {
                                withAnimation(.snappy) {
                                    self.selectedTags.removeAll(where: { $0 == tag })
                                }
                            }
                    }
                }
                .padding(.horizontal, 15)
                .frame(height: 35)
                .padding(.vertical, 15)
            }
            .scrollClipDisabled(true)
            .scrollIndicators(.hidden)
            .zIndex(1)
            .background(.white)
            .overlay {
                if self.selectedTags.isEmpty {
                    Text("Select at least 3 tags")
                        .font(.callout)
                        .foregroundStyle(.gray)
                }
            }
            
            ScrollView(.vertical) {
                TagLayout(alignment: .leading, spacing: 10) {
                    ForEach(self.tags.filter { !self.selectedTags.contains($0) }, id: \.self) { tag in
                        TagView(tag, .primaryBlue, "plus")
                            .matchedGeometryEffect(id: tag, in: self.animation)
                            .onTapGesture {
                                withAnimation(.snappy) {
                                    self.selectedTags.insert(tag, at: 0)
                                }
                            }
                    }
                }
                .padding(15)
            }
            .scrollClipDisabled(true)
            .scrollIndicators(.hidden)
            .background(.black.opacity(0.05))
            .zIndex(0)
            
            ZStack {
                Button(action: {}) {
                    Text("Continue")
                        .fontWeight(.semibold)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(RoundedRectangle(cornerRadius: 12).fill(.pink.gradient))
                }
            }
            .disabled(self.selectedTags.count < 3)
            .opacity(self.selectedTags.count < 3 ? 0.5 : 1)
            .padding()
            .background(.white)
            .zIndex(2)
        }
    }
    
    @ViewBuilder
    func TagView(_ tag: String, _ color: Color, _ icon: String) -> some View {
        HStack(spacing: 10) {
            Text(tag)
                .font(.callout)
                .fontWeight(.semibold)
            Image(systemName: icon)
        }
        .frame(height: 35)
        .foregroundStyle(.white)
        .padding(.horizontal, 15)
        .background(Capsule().fill(color.gradient))
    }
}

#Preview {
    FlowRowLayoutView()
}
