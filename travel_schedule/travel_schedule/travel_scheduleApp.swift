//
//  travel_scheduleApp.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 16.02.2025.
//

import SwiftUI

@main
struct travel_scheduleApp: App {
    private let coordinator = AppCoordinator()
    @StateObject private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            coordinator.start()
                .preferredColorScheme(themeManager.isDarkTheme ? .dark : .light)
                .environmentObject(themeManager)
        }
    }
}
