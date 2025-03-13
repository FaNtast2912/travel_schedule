//
//  ScheduleView.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 16.02.2025.
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        VStack(spacing: 20.0) {
            StoriesListView()
            ScheduleView()
            Spacer()
        }
    }
}


// MARK: - Previews
struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        let coordinator = AppCoordinator()
        coordinator.setupDependencies()
        
        return coordinator.start()
    }
}

struct MainScreenPreviewOnly_Previews: PreviewProvider {
    static var previews: some View {
        let coordinator = AppCoordinator()
        coordinator.setupDependencies()
        
        return MainScreen()
    }
}
