//
//  View+Ext+NavBar.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 14.03.2025.
//

import SwiftUI

extension View {
    func setupNavBarTitle() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .ypWhite
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 17, weight: .bold)]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
