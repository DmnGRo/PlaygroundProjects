//
//  NavigationView.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 10/12/2024.
//

import SwiftUI

struct NavigationView: View {
    @State private var showMenu: Bool = false
    @State private var selectedTab: SideMenuOption = .flowRowLayout
    
    var body: some View {
        NavigationStack {
            ZStack {
                switch selectedTab {
                case .collapsingHeader:
                    self.collapsingHeader
                        .tag(selectedTab.rawValue)
                case .marqueeTextEffect:
                    self.marqueeTextAnimation
                        .tag(selectedTab.rawValue)
                case .collapsingHeaderOtherApproach:
                    self.collapsingHeaderV2
                        .tag(selectedTab.rawValue)
                case .randomPlayground:
                    self.randomPlayground
                        .tag(selectedTab.rawValue)
                case .flowRowLayout:
                    self.flowRowLayout
                        .tag(selectedTab.rawValue)
                }
                NavigationView.SideMenu(isShowing: self.$showMenu,
                                        selectedOption: self.$selectedTab)
            }
            .toolbarVisibility(self.showMenu ? .hidden : .visible, for: .navigationBar)
            .toolbar {
                NavigationView.Toolbar(showMenu: self.$showMenu,
                                       placement: .topBarLeading)
            }
        }
    }
}

extension NavigationView {
    var collapsingHeader: some View {
        GeometryReader { proxy in
            CollapsingHeaderView(size: proxy.size,
                     safeArea: proxy.safeAreaInsets)
        }
    }
    
    var marqueeTextAnimation: some View {
        MarqueeTextView()
    }
    
    var collapsingHeaderV2: some View {
        CollapsingHeaderViewV2()
    }
    
    var randomPlayground: some View {
        RandomPlaygroundView()
    }
    
    var flowRowLayout: some View {
        FlowRowLayoutView()
    }
}

#Preview {
    NavigationView()
}
