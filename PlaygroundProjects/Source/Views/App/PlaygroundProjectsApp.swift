//
//  PlaygroundProjectsApp.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 10/12/2024.
//

import SwiftUI

@main
struct PlaygroundProjectsApp: App {
    @StateObject private var viewModel: StartUpViewModel = .init()
    
    @State private var isCompleted: Bool = false
    @State private var isLoading: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if !self.isLoading {
                    if self.isCompleted {
                        NavigationView(viewModel: .init(appSettingsRepository: DefaultAppSetttingsRepository()))
                    } else {
                        SetupAppView()
                    }
                } else {
                    SplashScreenView()
                        .onAppear {
                            self.viewModel.load()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                                withAnimation(.easeInOut(duration: 1)) {
                                    self.isCompleted = self.viewModel.isCompleted
                                    self.isLoading = false
                                }
                            }
                        }
                }
            }
        }
    }
}
