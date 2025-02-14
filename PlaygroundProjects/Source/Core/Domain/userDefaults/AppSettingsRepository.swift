//
//  AppSettingsRepository.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 14/02/2025.
//

protocol AppSettingsRepository {
    func setUpApp()
    func basicUserDefaults() -> BasicUserDefaults
}
