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
        let networkService = TravelServiceFacade()
        container.register(networkService, for: TravelServiceFacade.self)
        
        let scheduleViewModel = ScheduleViewModel()
        container.register(scheduleViewModel, for: ScheduleViewModel.self)
        
        let router = Router()
        container.register(router, for: Router.self)
        
        let screenFactory = ScreenFactory()
        container.register(screenFactory, for: ScreenFactory.self)
    }

    func start() -> some View {
        setupDependencies()
        return RouterView {
            TabBarView()
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
