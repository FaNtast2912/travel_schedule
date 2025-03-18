//
//  CircleButton.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 17.03.2025.
//

import SwiftUI

struct CircleButton: View {
    // MARK: - States
    @ObservedObject private var viewModel: ScheduleViewModel
    
    // MARK: - Public Properties
    let checkBox: Bool
    
    // MARK: - init
    init(checkBox: Bool) {
        guard let vm = DIContainer.shared.resolve(ScheduleViewModel.self) else {
            fatalError("Dependencies not registered")
        }
        self.viewModel = vm
        self.checkBox = checkBox
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            HStack {
                Text(checkBox ? "Да" : "Нет")
                Spacer()
                Image(systemName: viewModel.hasTransferFilter == checkBox ? "largecircle.fill.circle" : "circle")
                    .onTapGesture {
                        viewModel.hasTransferFilter = checkBox
                    }
            }
            .foregroundStyle(.ypBlack)
        }
        .frame(height: 60)
    }
}

#Preview {
    let coordinator = AppCoordinator.shared
    coordinator.setupDependencies()

    return CircleButton(checkBox: true)
}

