//
//  Properties.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 14/02/2025.
//

final class Properties {
    
    static let shared: Properties = {
        Properties(propertyStore: PersistedPropertyStore())
    }()
    
    let propertyStore: PropertyStore
    
    init (propertyStore: PropertyStore) {
        self.propertyStore = propertyStore
    }
}
