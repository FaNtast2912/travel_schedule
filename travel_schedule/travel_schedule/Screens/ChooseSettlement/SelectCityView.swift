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
    @State private var cities: [Settlement] = []
    @State private var mockCities: [Settlement] = [
        Settlement(title: "Москва", codes: nil, stations: []),
        Settlement(title: "Санкт-Петербург", codes: nil, stations: []),
        Settlement(title: "Сочи", codes: nil, stations: []),
        Settlement(title: "Горный воздух", codes: nil, stations: []),
        Settlement(title: "Краснодар", codes: nil, stations: []),
        Settlement(title: "Казань", codes: nil, stations: []),
        Settlement(title: "Омск", codes: nil, stations: []),
    ]
    
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
        List(mockCities) { city in
            Button(action: {
                viewModel.setSelectedCity(city)
                router.pop()
            }) {
                CityCellView(cityName: city.title ?? "")
            }
            .buttonStyle(PlainButtonStyle())
        }
        .navigationTitle("Выберите город")
    }
}

// MARK: - Previews
#Preview {
    let coordinator = AppCoordinator()
    coordinator.setupDependencies()
    
    return SelectCityView()
}
