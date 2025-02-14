//
//  NavigationView.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 10/12/2024.
//

import SwiftUI

struct NavigationView: View {
    
    @StateObject var viewModel: NavigationViewViewModel
    
    @State private var showMenu: Bool = false
    @State private var selectedTab: SideMenuOption = SideMenuOption.allCases.first!
    
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
                case .stickyHeader:
                    self.stickyHeaderView
                        .tag(selectedTab.rawValue)
                }
                NavigationView.SideMenu(isShowing: self.$showMenu,
                                        selectedOption: self.$selectedTab,
                                        email: self.viewModel.email,
                                        username: self.viewModel.username,
                                        version: self.viewModel.buildVersion)
            }
            .toolbarVisibility(self.showMenu ? .hidden : .visible, for: .navigationBar)
            .toolbar {
                NavigationView.Toolbar(showMenu: self.$showMenu,
                                       placement: .topBarLeading)
            }
            .onAppear {
                self.viewModel.load()
            }
        }
    }
}

extension NavigationView {
    var underConstructionsView: some View {
        UnderConstructionView()
    }
    
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
        Group {
            if Properties.shared.collapsingHeaderAlternative {
                CollapsingHeaderViewV2()
            } else {
                self.underConstructionsView
            }
        }
    }
    
    var randomPlayground: some View {
        RandomPlaygroundView()
    }
    
    var flowRowLayout: some View {
        FlowRowLayoutView()
    }
    
    var stickyHeaderView: some View {
        StickyHeaderView()
    }
}

#Preview {
    NavigationView(viewModel: .init(appSettingsRepository: DefaultAppSetttingsRepository()))
}
