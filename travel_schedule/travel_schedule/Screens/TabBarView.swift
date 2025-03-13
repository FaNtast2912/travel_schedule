//
//  ContentView.swift
//  Navigation SwiftUI
//
//  Created by Maksim Zakharov on 16.02.2025.
//

import SwiftUI

struct TabBarView: View {
    
    enum ButtonStyle: String {
        case settingsButton = "settingsButton"
        case scheduleButton = "scheduleButton"
    }
    
    var body: some View {
        TabView {
            MainScreen()
                .tabItem {
                    Label("", image: ButtonStyle.scheduleButton.rawValue)
                }
            
            SettingsView()
                .tabItem {
                    Label("", image: ButtonStyle.settingsButton.rawValue)
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        let coordinator = AppCoordinator()
        coordinator.setupDependencies()
        
        return coordinator.start()
    }
}
