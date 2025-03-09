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

#Preview {
    let viewModel = ScheduleViewModel()
    let router = Router()
    let factory = ScreenFactory()
    DIContainer.shared.register(viewModel, for: ScheduleViewModel.self)
    DIContainer.shared.register(router, for: Router.self)
    DIContainer.shared.register(factory, for: ScreenFactory.self)
    
    return RouterView {
        TabBarView()
    }
}
