//
//  SwiftUIView.swift
//  Navigation SwiftUI
//
//  Created by Maksim Zakharov on 16.02.2025.
//

import SwiftUI

struct CarriersListView: View {
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
        setupNavBarTitle()
    }
    
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            VStack(spacing: 16) {
                headerView
                
                if viewModel.filteredSegments.isEmpty {
                    Spacer()
                    ProgressView()
                } else if !viewModel.filteredSegments.isEmpty {
                    ZStack(alignment: .bottom) {
                        lazyListView
                        depatureIntervalButton
                    }
                } else {
                    Spacer()
                    Text("Вариантов нет")
                }
                Spacer()
                    .toolbarRole(.editor)
            }
            .foregroundStyle(.ypBlack)
            .padding(16)
        }
    }
    
    private var headerView: some View {
        Group {
            Text("\(viewModel.selectedStartCity?.title ?? "")" + " (\(viewModel.selectedEndCity?.title ?? "")) ") +
            Text(" -> ") +
            Text("\(viewModel.selectedStartStation?.title ?? "")" + " (\(viewModel.selectedEndStation?.title ?? "")) ")
        }
        .font(.system(size: 24, weight: .bold))
    }
    
    private var lazyListView: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(viewModel.filteredSegments) { segment in
                    CarrierCardView(
                        segment: segment,
                        startDate: "segment.departure",
                        departureTime: "segment.departure",
                        arrivalTime: "segment.arrival"
                    )
                    .frame(height: 104)
                    .onTapGesture {
                        router.backToRoot()
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private var depatureIntervalButton: some View {
        VStack {
            Spacer()
            Button {
                router.backToRoot()
            } label: {
                buttonView
            }
            .frame(idealWidth: 343, maxWidth: .infinity, maxHeight: 60)
            .background(.ypBlue)
            .clipShape(.rect(cornerRadius: 16))
            .padding(.bottom, 8)
        }
    }
    
    private var buttonView: some View {
        Label {
            HStack {
                Text("Уточнить время")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.ypWhiteConstant)
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundStyle(viewModel.hasFilters ? .ypRed : .ypBlue)
            }
        } icon: {}
    }
}

#Preview {
    CarriersListView()
}
