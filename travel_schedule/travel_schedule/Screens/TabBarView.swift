//
//  ContentView.swift
//  Navigation SwiftUI
//
//  Created by Maksim Zakharov on 16.02.2025.
//

import SwiftUI

struct TabBarView: View {
    
    enum TabItemType: String, CaseIterable {
        case schedule = "scheduleButton"
        case settings = "settingsButton"
    }
    
    var body: some View {
        TabView {
            createTab(view: MainScreen(), type: .schedule)
            createTab(view: SettingsView(), type: .settings)
        }
    }
    
    @ViewBuilder
    private func createTab<V: View>(view: V, type: TabItemType) -> some View {
        view
            .tabItem {
                Image(type.rawValue)
            }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        let coordinator = AppCoordinator.shared
        coordinator.setupDependencies()
        
        return coordinator.start()
    }
}
