//
//  Bundle.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 14/02/2025.
//

import Foundation

extension Bundle {
    var buildVersion: String {
        self.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "-"
    }
}
