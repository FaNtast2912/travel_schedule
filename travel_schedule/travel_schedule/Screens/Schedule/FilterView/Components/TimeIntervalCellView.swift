//
//  TimeIntervalCellView.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 17.03.2025.
//

import SwiftUI

struct TimeIntervalCellView: View {
    // MARK: - States
    @ObservedObject private var viewModel: ScheduleViewModel
    
    // MARK: - Public Properties
    let timeInterval: TimeIntervals
    
    // MARK: - init
    init(timeInterval: TimeIntervals) {
        guard let vm = DIContainer.shared.resolve(ScheduleViewModel.self) else {
            fatalError("Dependencies not registered")
        }
        self.viewModel = vm
        self.timeInterval = timeInterval
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            HStack {
                Text(timeInterval.rawValue)
                Spacer()
                Image(systemName: viewModel.filters.contains(timeInterval) ? "checkmark.square.fill" : "square")
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        if !viewModel.filters.contains(timeInterval) {
                            viewModel.filters.append(timeInterval)
                        } else {
                            viewModel.filters = viewModel.filters.filter { $0 != timeInterval}
                        }
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

    return TimeIntervalCellView(timeInterval: .morning)
}

