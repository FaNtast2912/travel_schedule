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
            StoriesView()
            ScheduleView()
            Spacer()
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
    
    return MainScreen()
}
