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
        }
    }
}

extension SideMenuOption: Identifiable {
    public var id: Int { self.rawValue }
}
