//
//  FirstView.swift
//  Navigation SwiftUI
//
//  Created by Maksim Zakharov on 16.02.2025.
//

import SwiftUI

struct SelectCityView: View {
    // MARK: - States
    @ObservedObject private var viewModel: ScheduleViewModel
    @ObservedObject private var router: Router

    // MARK: - init
    init() {
        guard let vm = DIContainer.shared.resolve(ScheduleViewModel.self),
              let r = DIContainer.shared.resolve(Router.self) else {
            fatalError("Dependencies not registered")
        }
        self.viewModel = vm
        self.router = r
    }

    // MARK: - Body
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.filteredSettlements) { city in
                        Button(action: {
                            viewModel.setSelectedCity(city)
                            router.pop()
                        }) {
                            CityCellView(cityName: city.title!)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.leading, 18)
                    }
                }
            }
        }
        .navigationTitle("Выберите город")
    }
}

// MARK: - Previews
//#Preview {
//    let coordinator = AppCoordinator()
//    coordinator.setupDependencies()
//    
//    return SelectCityView()
//}
