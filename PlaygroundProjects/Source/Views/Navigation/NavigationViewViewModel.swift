//
//  NavigationViewViewModel.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 14/02/2025.
//

import Foundation
import SwiftUI

@MainActor
final class NavigationViewViewModel: ObservableObject {
    
    let appSettingsRepository: AppSettingsRepository
    
    @Published private var basicDefaults: BasicUserDefaults? = nil
    
    init(appSettingsRepository: AppSettingsRepository) {
        self.appSettingsRepository = appSettingsRepository
    }
    
    func load() {
        self.appSettingsRepository.setUpApp()
        self.basicDefaults = self.appSettingsRepository.basicUserDefaults()
    }
}

extension NavigationViewViewModel {
    var buildVersion: String {
        self.basicDefaults?.buildVersing ?? "Unknown"
    }
    
    var email: String {
        self.basicDefaults?.email ?? "Unknown"
    }
    
    var username: String {
        self.basicDefaults?.username ?? "Unknown"
    }
}
