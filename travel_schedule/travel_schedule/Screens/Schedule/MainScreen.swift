//
//  ScheduleView.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 16.02.2025.
//

import SwiftUI

struct MainScreen: View {
    
    @StateObject private var viewModel = MainScreenViewModel()
    @EnvironmentObject private var router: Router
    
    var body: some View {
        VStack(spacing: 20.0) {
            StoriesView()
            ScheduleView(viewModel: viewModel)
            Spacer()
        }
    }
}

#Preview {
    MainScreen()
}
