//
//  NavigationView+SideMenu+Model.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 10/12/2024.
//

import Foundation

enum SideMenuOption: Int, CaseIterable {
    case collapsingHeader
    case marqueeTextEffect
    
    var title: String {
        switch self {
        case .collapsingHeader:
            return "Collapsing Header"
        case .marqueeTextEffect:
            return "Marquee Text Effect"
        }
    }
    
    var image: String {
        switch self {
        case .collapsingHeader:
            return "widget.medium"
        case .marqueeTextEffect:
            return "text.word.spacing"
        }
    }
}

extension SideMenuOption: Identifiable {
    public var id: Int { self.rawValue }
}
