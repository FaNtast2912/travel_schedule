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
            VStack(spacing: 16){
                headerView
                VStack(spacing: 16) {
                    if viewModel.filteredSegments.isEmpty, !viewModel.hasFilters {
                        Spacer()
                        ProgressView()
                    } else if !viewModel.filteredSegments.isEmpty {
                        ZStack(alignment: .bottom) {
                            lazyListView
                            depatureIntervalButton
                        }
                    } else {
                        noSegmentsView
                    }
                    Spacer()
                        .background(Color.clear)
                        .toolbarRole(.editor)
                    
                }
                .foregroundStyle(.ypBlack)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
        .customNavigationModifier(router: router, viewModel: viewModel, title: "")
    }
    
    private var noSegmentsView: some View {
        ZStack {
            Text("Вариантов нет")
                .font(.system(size: 24,weight: .bold))
                .padding(.bottom, 16)
            
            VStack {
                Spacer()
                depatureIntervalButton
            }
        }
        .frame(maxHeight: .infinity)
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
                    CarrierCellView(
                        segment: segment
                    )
                    .frame(height: 104)
                    .onTapGesture {
                        viewModel.selectedCarrier = segment.thread?.carrier
                        router.push(.carrierCardView)                    }
                }
                Color.clear.frame(height: 68)
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private var depatureIntervalButton: some View {
        VStack {
            Spacer()
            Button {
                router.push(.filterView)
            } label: {
                buttonView
                    .frame(idealWidth: 343, maxWidth: .infinity, maxHeight: 60)
                    .background(.ypBlue)
                    .clipShape(.rect(cornerRadius: 16))
            }
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    let coordinator = AppCoordinator.shared
    coordinator.setupDependencies()
    
    return CarriersListView()
}
