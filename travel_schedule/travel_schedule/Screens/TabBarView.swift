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
            // Вкладка с расписанием
            MainScreen()
                .tabItem {
                    Label("Главная", image: ButtonStyle.scheduleButton.rawValue)
                }
                
            
            // Вкладка настроек
            SettingsView()
                .tabItem {
                    Label("Настройки", image: ButtonStyle.settingsButton.rawValue)
                }
        }
    }
}

#Preview {
    let viewModel = ScheduleViewModel()
    let router = Router()
    DIContainer.shared.register(viewModel, for: ScheduleViewModel.self)
    DIContainer.shared.register(router, for: Router.self)
    
    return RouterView {
        TabBarView()
    }
}
