//
//  FirstView.swift
//  Navigation SwiftUI
//
//  Created by Maksim Zakharov on 16.02.2025.
//

import SwiftUI

struct FirstView: View {
    
    @ObservedObject private var viewModel: ScheduleViewModel
    @ObservedObject private var router: Router
    
    init() {
        guard let vm = DIContainer.shared.resolve(ScheduleViewModel.self),
              let r = DIContainer.shared.resolve(Router.self) else {
            fatalError("Dependencies not registered")
        }
        self.viewModel = vm
        self.router = r
    }
    
    let cities = ["Москва", "Санкт-Петербург", "Казань", "Новосибирск", "Екатеринбург"]
    
    var body: some View {
        List(cities, id: \.self) { city in
            Button(action: {
                viewModel.setSelectedCity(city)
                router.pop()
            }) {
                Text(city)
            }
        }
        .navigationTitle("Выберите город")
    }
}

#Preview {
    let viewModel = ScheduleViewModel()
    let router = Router()
    let factory = ScreenFactory()
    DIContainer.shared.register(viewModel, for: ScheduleViewModel.self)
    DIContainer.shared.register(router, for: Router.self)
    DIContainer.shared.register(factory, for: ScreenFactory.self)
    
    return FirstView()

}
