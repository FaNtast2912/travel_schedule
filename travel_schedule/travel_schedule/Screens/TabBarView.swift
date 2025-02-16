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
            ScheduleView()
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
    RouterView {
        TabBarView()
    }
}
