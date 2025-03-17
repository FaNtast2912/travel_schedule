//
//  FilterView.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 17.03.2025.
//

import SwiftUI

struct FilterView: View {
    
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
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 16) {
                Text("Время отправления")
                    .font(.system(size: 24, weight: .bold))
                
                timeIntervalsView
                
                Text("Показывать варианты с пересадками")
                    .font(.system(size: 24, weight: .bold))
                
                hasTransferSelectionView
                
                Spacer()
                
                applyFilterButton
                
            }
            .padding(16)
        }
        .customNavigationModifier(router: router, viewModel: viewModel, title: "")
    }
    private var timeIntervalsView: some View {
        VStack(alignment: .leading, spacing: 0) {
            TimeIntervalCellView(timeInterval: .morning)
            TimeIntervalCellView(timeInterval: .afternoon)
            TimeIntervalCellView(timeInterval: .evening)
            TimeIntervalCellView(timeInterval: .night)
        }
    }
    
    private var hasTransferSelectionView: some View {
        VStack(alignment: .leading, spacing: 0) {
            CircleButton(checkBox: true)
            CircleButton(checkBox: false)
        }
    }
    
    private var applyFilterButton: some View {
        Button {
            viewModel.applyFilters()
            viewModel.hasFilters = !viewModel.filters.isEmpty || viewModel.hasTransferFilter
            router.pop()
        } label: {
            Label {
                HStack {
                    Text("Применить")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.ypWhite)
                }
            } icon: {}
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        .frame(idealWidth: 343, maxWidth: .infinity, maxHeight: 60)
        .background(.ypBlue)
        .clipShape(.rect(cornerRadius: 16))
        .padding(.bottom, 24)
        .toolbarRole(.editor)
    }
    
}

#Preview {
    FilterView()
}
