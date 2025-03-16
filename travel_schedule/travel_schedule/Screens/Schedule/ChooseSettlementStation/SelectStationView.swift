//
//  SecondView.swift
//  Navigation SwiftUI
//
//  Created by Maksim Zakharov on 16.02.2025.
//

import SwiftUI

struct SelectStationView: View {
    // MARK: - States
    @ObservedObject private var viewModel: ScheduleViewModel
    @ObservedObject private var router: Router
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    
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
    
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            SearchBarView
            ZStack {
                if viewModel.allStations == nil {
                    ProgressView()
                        .padding()
                } else if viewModel.filteredSettlements.isEmpty {
                    searchResultsStub
                } else {
                    lazyListView
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .customNavigationModifier(router: router, viewModel: viewModel, title: "Выбор станции")
    }
    
    private var SearchBarView: some View {
        SearchBar(searchText: $searchText, isSearching: $isSearching, placeholder: "Введите запрос")
            .padding(.bottom, 16)
            .onChange(of: searchText) { newValue in
                viewModel.searchText = newValue
            }
    }
    
    private var searchResultsStub: some View {
        Text("Станция не найдена")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var lazyListView: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.filteredStations) { station in
                    Button(action: {
                        viewModel.setSelectedStation(station)
                        router.backToRoot()
                        viewModel.resetStationSelection()
                    }) {
                        let name = station.title
                        ScheduleCellView(cityName: name)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.leading, 18)
                }
            }
        }
    }
}

#Preview {
    let coordinator = AppCoordinator()
    coordinator.setupDependencies()

    return SelectStationView()
}
