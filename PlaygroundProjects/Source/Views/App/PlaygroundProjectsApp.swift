//
//  PlaygroundProjectsApp.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 10/12/2024.
//

import SwiftUI

@main
struct PlaygroundProjectsApp: App {
    
    private let appSettingsRepository: AppSettingsRepository = DefaultAppSetttingsRepository()
    
    var body: some Scene {
        WindowGroup {
            NavigationView(viewModel: NavigationViewViewModel(appSettingsRepository: self.appSettingsRepository))
        }
    }
}
