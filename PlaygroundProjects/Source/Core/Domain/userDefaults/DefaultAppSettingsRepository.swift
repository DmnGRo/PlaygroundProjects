//
//  DefaultAppSettingsRepository.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 14/02/2025.
//

import Foundation

final class DefaultAppSetttingsRepository: AppSettingsRepository {
    
    func setUpApp() {
        Properties.shared.synchronize()
        Properties.shared.buildVersion = Bundle.main.buildVersion
    }
    
    func basicUserDefaults() -> BasicUserDefaults {
        return BasicUserDefaults(buildVersing: Properties.shared.buildVersion,
                                 email: Properties.shared.userEmail,
                                 username: Properties.shared.username)
    }
}
