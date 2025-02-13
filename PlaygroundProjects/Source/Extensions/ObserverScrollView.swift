//
//  ObserverScrollView.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 23/12/2024.
//

import SwiftUI
import Combine

struct ObserverScrollView<T: View>: View {
    @State private var scrollEndTarget = ScrollEndTarget<String>(id: nil, offset: .zero)
    @State private var coordinateNamespace: String = "ObserverScrollView\(UUID().uuidString)"
    @State private var mainViewId: String = "MainView\(UUID().uuidString)"
    
    var content: T
    var onOffsetChanged: (CGFloat) -> Void
    var onDragEnded: () -> Void
    
    private let targetOffsetSubject: PassthroughSubject<ScrollEndTarget<String>, Never>
    private let debouncerTargetOffsetSubject: AnyPublisher<ScrollEndTarget<String>, Never>
    
    init(onOffsetChanged: @escaping (CGFloat) -> Void, onDragEnded: @escaping () -> Void = {}, content: T) {
        self.content = content
        self.onOffsetChanged = onOffsetChanged
        self.onDragEnded = onDragEnded
        self.targetOffsetSubject = PassthroughSubject<ScrollEndTarget<String>, Never>()
        self.debouncerTargetOffsetSubject = self.targetOffsetSubject
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            self.content
                .overlay {
                    GeometryReader { geometry in
                        Color.clear
                            .preference(key: ObserverScrollViewPreferenceKey.self,
                                        value: geometry.frame(in: .named(self.coordinateNamespace)).origin.y)
                    }
                }
                .onReceive(self.debouncerTargetOffsetSubject) { scrollEndTarget in
                    self.onDragEnded()
                }
        }
        .coordinateSpace(name: self.coordinateNamespace)
        .onPreferenceChange(ObserverScrollViewPreferenceKey.self, perform: self.onOffsetChanged)
        .simultaneousGesture(DragGesture().onEnded { value in
            let scrollEndTarget = ScrollEndTarget(id: self.mainViewId, offset: value.location.y)
            self.targetOffsetSubject.send(scrollEndTarget)
            self.onDragEnded()
        })
    }
}

private struct ObserverScrollViewPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

private struct ScrollEndTarget<ID>: Hashable where ID: Hashable {
    let id: ID?
    let offset: CGFloat
}
