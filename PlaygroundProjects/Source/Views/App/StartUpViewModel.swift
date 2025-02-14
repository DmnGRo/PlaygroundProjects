//
//  StartUpViewModel.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 14/02/2025.
//

import Foundation

@MainActor
class StartUpViewModel: ObservableObject {
    func load() {
        Properties.shared.synchronize()
    }
}

extension StartUpViewModel {
    var isCompleted: Bool {
        Properties.shared.userEmail?.isEmpty == false &&
        Properties.shared.username?.isEmpty == false
    }
}

