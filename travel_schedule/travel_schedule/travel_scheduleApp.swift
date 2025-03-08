//
//  travel_scheduleApp.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 09.02.2025.
//

import SwiftUI

@main
struct travel_scheduleApp: App {
    
    init() {
        customizeTabBarAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
    
    private func customizeTabBarAppearance() {
        let appearance = UITabBarAppearance()

        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .ypWhite
        
        appearance.shadowColor = .ypBlackConstant
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.ypGray]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.ypBlack]
        appearance.stackedLayoutAppearance.normal.iconColor = .ypGray
        appearance.stackedLayoutAppearance.selected.iconColor = .ypBlack
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
