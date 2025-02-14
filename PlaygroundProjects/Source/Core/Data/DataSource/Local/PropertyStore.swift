//
//  PropertyStore.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 14/02/2025.
//

protocol PropertyStore {
    func synchronize()
    func bool(key: PropertyKey, default defaultValue: Bool) -> Bool
    func dictionary(key: PropertyKey) -> [String: Any]?
    func string(key: PropertyKey, defaultValue: String) -> String?
    func double(key: PropertyKey, defaultValue: Double) -> Double
    func int(key: PropertyKey, defaultValue: Int) -> Int
    
    func remove(key: PropertyKey)
    
    func set(_ value: Bool?, forKey key: PropertyKey)
    func set(_ value: [String: Any]?, forKey key: PropertyKey)
    func set(_ value: Double?, forKey: PropertyKey)
    func set(_ value: Int?, forKey key: PropertyKey)
    func set(_ value: String?, forKey key: PropertyKey)
}

extension PropertyStore {
    func bool(key: PropertyKey) -> Bool {
        self.bool(key: key, default: false)
    }
}

enum PropertyKey: String {
    case buildVersion = "com.dgr.playground.buildVersion"
    case collapsingHeaderAlternative = "com.dgr.playground.collapsingHeaderAlternative"
    case defaultEmail = "com.dgr.playground.email"
    case defaultUsername = "com.dgr.playground.username"
    case versionCode = "com.dgr.playground.versionCode"
}
