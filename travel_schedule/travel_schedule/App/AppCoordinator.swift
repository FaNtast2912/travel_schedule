//
//  AppCoordinator.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 08.03.2025.
//

import SwiftUI

@MainActor
final class AppCoordinator {
    // MARK: - Public Properties
    static let shared = AppCoordinator()
    
    // MARK: - Private Properties
    private let container = DIContainer.shared
    private let router = Router.shared
    
    // MARK: - init
    private init() {
        customizeTabBarAppearance()
    }
    
    // MARK: - Public methods
    func setupDependencies() {
        let storyViewModel = StoryViewModel()
        container.register(storyViewModel, for: StoryViewModel.self)
        
        let networkMonitor = NetworkMonitor()
            container.register(networkMonitor, for: NetworkMonitor.self)
        
        let themeManager = ThemeManager.shared
                container.register(themeManager, for: ThemeManager.self)
        
        let screenFactory = ScreenFactory()
        container.register(screenFactory, for: ScreenFactory.self)
        
        container.register(router, for: Router.self)
        
        let networkService = TravelServiceFacade()
        container.register(networkService, for: TravelServiceFacade.self)
        
        let scheduleViewModel = ScheduleViewModel()
        container.register(scheduleViewModel, for: ScheduleViewModel.self)
        
    }

    func start() -> some View {
        setupDependencies()
        return RouterView {
            TabBarView()
        }
    }
    
    func updateTabBarAppearance() {
        customizeTabBarAppearance()
    }
    
    // MARK: - Private methods
    private func customizeTabBarAppearance() {
        let appearance = UITabBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(.ypWhite)
        
        appearance.shadowColor = UIColor(.tabBarBlack)
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(.ypGray)]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(.ypBlack)]
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(.ypGray)
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(.ypBlack)
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
