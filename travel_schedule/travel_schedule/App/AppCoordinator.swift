//
//  AppCoordinator.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 08.03.2025.
//

import SwiftUI

@MainActor
final class AppCoordinator {
    
    let container = DIContainer.shared
    
    init() {
        customizeTabBarAppearance()
    }
    
    func setupDependencies() {
        let networkMonitor = NetworkMonitor()
            container.register(networkMonitor, for: NetworkMonitor.self)
        
        let themeManager = ThemeManager()
                container.register(themeManager, for: ThemeManager.self)
        
        let screenFactory = ScreenFactory()
        container.register(screenFactory, for: ScreenFactory.self)
        
        let router = Router()
        container.register(router, for: Router.self)
        
        let networkService = TravelServiceFacade()
        container.register(networkService, for: TravelServiceFacade.self)
        
        let scheduleViewModel = ScheduleViewModel()
        container.register(scheduleViewModel, for: ScheduleViewModel.self)
        
    }

    func start() -> some View {
        setupDependencies()
        guard let themeManager = container.resolve(ThemeManager.self) else {
            fatalError("ThemeManager not registered")
        }
        
        return RouterView {
            TabBarView()
                .environmentObject(themeManager)
        }
    }
    
    private func customizeTabBarAppearance() {
        let appearance = UITabBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(.ypWhite)
        
        appearance.shadowColor = UIColor(.ypBlackConstant)
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(.ypGray)]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(.ypBlack)]
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(.ypGray)
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(.ypBlack)
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    func updateTabBarAppearance(isDark: Bool) {
        let appearance = UITabBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = isDark ? UIColor(.ypBlack) : UIColor(.ypWhite)
        
        // TO DO возможно дополнительно надо поменять цвета
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
