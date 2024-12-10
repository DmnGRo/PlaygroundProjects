//
//  Comparable.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 10/12/2024.
//

import Foundation

public extension Comparable {
    func clamped(_ minimum: Self, _ maximum: Self) -> Self {
        max(minimum, min(maximum, self))
    }
}
