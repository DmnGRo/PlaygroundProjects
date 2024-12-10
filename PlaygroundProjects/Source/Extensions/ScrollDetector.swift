//
//  ScrollDetector.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 10/12/2024.
//

import SwiftUI

struct ScrollDetector: UIViewRepresentable {
    
    var onScroll: (CGFloat) -> ()
    
    var onDragEnded: (CGFloat, CGFloat) -> ()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            if let scrollView = uiView.superview?.superview?.superview as? UIScrollView,
               !context.coordinator.isDelegateAdded {
                scrollView.delegate = context.coordinator
                context.coordinator.isDelegateAdded = true
            }
        }
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        
        var parent: ScrollDetector
        var isDelegateAdded: Bool = false
        
        init(parent: ScrollDetector) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.onScroll(scrollView.contentOffset.y)
        }
        
        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            parent.onDragEnded(targetContentOffset.pointee.y, velocity.y)
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let velocity = scrollView.panGestureRecognizer.velocity(in: scrollView.panGestureRecognizer.view)
            parent.onDragEnded(scrollView.contentOffset.y, velocity.y)
        }
    }
}
