//
//  ThemeManager.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 17.03.2025.
//

import Foundation
import SwiftUI

final class ThemeManager: ObservableObject {
    @AppStorage("isDarkTheme") var isDarkTheme: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    private func updateAppearance() {
        DispatchQueue.main.async {
            AppCoordinator().updateTabBarAppearance(isDark: self.isDarkTheme)
        }
    }
}
