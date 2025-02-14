//
//  PersistedPropertyStore.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 14/02/2025.
//

import Foundation

final class PersistedPropertyStore: PropertyStore {
    func synchronize() {
        guard let settingsUrl = Bundle.main.url(forResource: "Settings", withExtension: "bundle"),
              let settingsData = try? Data(contentsOf: settingsUrl.appendingPathComponent("Root.plist")),
              let settingsPList = try? PropertyListSerialization.propertyList(from: settingsData, options: [], format: nil) as? [String: Any],
              let preferences = settingsPList["PreferenceSpecifiers"] as? [[String: Any]] else {
            return
        }
        
        var defaults: [String: Any] = [:]
        for preference in preferences {
            if let key = preference["Key"] as? String {
                defaults[key] = preference["DefaultValue"]
            }
        }
        
        UserDefaults.standard.register(defaults: defaults)
    }
    
    func bool(key: PropertyKey, default defaultValue: Bool) -> Bool {
        if UserDefaults.standard.object(forKey: key.rawValue) != nil {
            return UserDefaults.standard.bool(forKey: key.rawValue)
        }
        return defaultValue
    }
    
    func dictionary(key: PropertyKey) -> [String : Any]? {
        if UserDefaults.standard.object(forKey: key.rawValue) != nil {
            return UserDefaults.standard.dictionary(forKey: key.rawValue)
        }
        return nil
    }
    
    func string(key: PropertyKey, defaultValue: String) -> String? {
        if UserDefaults.standard.object(forKey: key.rawValue) != nil {
            return UserDefaults.standard.string(forKey: key.rawValue)
        }
        return defaultValue
    }
    
    func double(key: PropertyKey, defaultValue: Double) -> Double {
        if UserDefaults.standard.object(forKey: key.rawValue) != nil {
            return UserDefaults.standard.double(forKey: key.rawValue)
        }
        return defaultValue
    }
    
    func int(key: PropertyKey, defaultValue: Int) -> Int {
        if UserDefaults.standard.object(forKey: key.rawValue) != nil {
            return UserDefaults.standard.integer(forKey: key.rawValue)
        }
        return defaultValue
    }
    
    func remove(key: PropertyKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    func set(_ value: Bool?, forKey key: PropertyKey) {
        guard let value else {
            return self.remove(key: key)
        }
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func set(_ value: [String : Any]?, forKey key: PropertyKey) {
        guard let value else {
            return self.remove(key: key)
        }
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func set(_ value: Double?, forKey key: PropertyKey) {
        guard let value else {
            return self.remove(key: key)
        }
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func set(_ value: Int?, forKey key: PropertyKey) {
        guard let value else {
            return self.remove(key: key)
        }
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func set(_ value: String?, forKey key: PropertyKey) {
        guard let value else {
            return self.remove(key: key)
        }
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
}
