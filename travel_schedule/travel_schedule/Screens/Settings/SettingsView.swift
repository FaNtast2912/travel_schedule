//
//  SettingsView.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 16.02.2025.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - States
    @ObservedObject private var router: Router
    @ObservedObject private var themeManager: ThemeManager
    
    // MARK: - init
    init() {
        guard let r = DIContainer.shared.resolve(Router.self), let themeManager = DIContainer.shared.resolve(ThemeManager.self) else {
            fatalError("Dependencies not registered")
        }
        self.router = r
        self.themeManager = themeManager
        setupNavBarTitle()
    }
    
    var body: some View {
           ZStack {
               Color.ypWhite.ignoresSafeArea()
               VStack {
                   themeSwitch
                   userAgreementView
                   Spacer()
                   appInfoView
               }
               .foregroundStyle(.ypBlack)
               .padding(16)
           }
       }
    
    private var userAgreementView: some View {
        HStack() {
            Text("Пользовательское соглашение")
            Spacer()
            Image(systemName: "chevron.right")
        }
        .foregroundStyle(.ypBlack)
        .background(.ypWhite)
        .frame(height: 60)
        .onTapGesture {
            router.push(.userAreementView)
        }
    }
    
    private var themeSwitch: some View {
        Toggle("Темная тема", isOn: $themeManager.isDarkTheme)
            .toggleStyle(SwitchToggleStyle(tint: .ypBlue))
            .frame(height: 60)
    }
    
    private var appInfoView: some View {
        VStack(spacing: 12) {
            Text("Приложение использует API «Яндекс.Расписания»")
            Text("Версия 1.0 (beta)")
        }
        .foregroundStyle(.ypBlack)
        .font(.system(size: 12, weight: .regular))
    }
}


#Preview {
    let coordinator = AppCoordinator.shared
    coordinator.setupDependencies()
    
    return SettingsView()
}
