//
//  DIContainer.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 08.03.2025.
//

import SwiftUI

final class DIContainer {
    static let shared = DIContainer()
    
    private init() {}
    
    private var dependencies: [String: Any] = [:]
    
    func register<T>(_ dependency: T, for type: T.Type) {
        let key = String(describing: type)
        dependencies[key] = dependency
    }
    
    func resolve<T>(_ type: T.Type) -> T? {
        let key = String(describing: type)
        return dependencies[key] as? T
    }
    
    func remove<T>(_ type: T.Type) {
        let key = String(describing: type)
        dependencies.removeValue(forKey: key)
    }
    
    func clear() {
        dependencies.removeAll()
    }
}
