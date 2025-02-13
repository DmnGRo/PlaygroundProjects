//
//  NavigationView+SideMenu+Model.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 10/12/2024.
//

import Foundation

enum SideMenuOption: Int, CaseIterable {
    case collapsingHeader
    case collapsingHeaderOtherApproach
    case marqueeTextEffect
    case randomPlayground
    case flowRowLayout
    case stickyHeader
    
    var title: String {
        switch self {
        case .collapsingHeader:
            return "Collapsing Header"
        case .marqueeTextEffect:
            return "Marquee Text Effect"
        case .collapsingHeaderOtherApproach:
            return "Collapsing Header Other Approach"
        case .randomPlayground:
            return "Random Playground"
        case .flowRowLayout:
            return "Flow Row Layout"
        case .stickyHeader:
            return "Sticky Header"
        }
    }
    
    var image: String {
        switch self {
        case .collapsingHeader:
            return "widget.medium"
        case .marqueeTextEffect:
            return "text.word.spacing"
        case .collapsingHeaderOtherApproach:
            return "widget.medium"
        case .randomPlayground:
            return "pencil.circle"
        case .flowRowLayout:
            return "text.word.spacing"
        case .stickyHeader:
            return "tray.2"
        }
    }
}

extension SideMenuOption: Identifiable {
    public var id: Int { self.rawValue }
}
