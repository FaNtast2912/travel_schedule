//
//  ThemeManager.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 17.03.2025.
//

import Foundation
import SwiftUI

@MainActor
final class ThemeManager: ObservableObject {
    
    static let shared = ThemeManager()
    
    let coordinator = AppCoordinator.shared
    
    private init() {
    }
    
    @AppStorage("isDarkTheme") var isDarkTheme: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    private func updateAppearance() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            coordinator.updateTabBarAppearance()
        }
    }
}
