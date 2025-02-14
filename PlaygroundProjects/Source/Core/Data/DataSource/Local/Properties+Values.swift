//
//  Properties+Values.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 14/02/2025.
//

extension Properties {
    
    func synchronize() {
        self.propertyStore.synchronize()
    }
    
    var buildVersion: String? {
        get { return self.propertyStore.string(key: .buildVersion, defaultValue: "") }
        set { self.propertyStore.set(newValue, forKey: .buildVersion) }
    }
    var collapsingHeaderAlternative: Bool {
        get { return self.propertyStore.bool(key: .collapsingHeaderAlternative) }
        set { self.propertyStore.set(newValue, forKey: .collapsingHeaderAlternative) }
    }
    var userEmail: String? {
        get { return self.propertyStore.string(key: .defaultEmail, defaultValue: "") }
        set { self.propertyStore.set(newValue, forKey: .defaultEmail) }
    }
    var username: String? {
        get { return self.propertyStore.string(key: .defaultUsername, defaultValue: "") }
        set { self.propertyStore.set(newValue, forKey: .defaultUsername) }
    }
}
