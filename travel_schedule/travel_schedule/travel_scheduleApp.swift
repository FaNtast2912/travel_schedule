//
//  travel_scheduleApp.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 16.02.2025.
//

import SwiftUI

@main
struct travel_scheduleApp: App {
    private let coordinator = AppCoordinator.shared
    @StateObject private var themeManager = ThemeManager.shared
    
    var body: some Scene {
        WindowGroup {
            coordinator.start()
                .preferredColorScheme(themeManager.isDarkTheme ? .dark : .light)
        }
    }
}
