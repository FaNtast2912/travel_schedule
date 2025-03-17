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
                .onAppear {
                    viewModel.shouldSearchCity = true
                    viewModel.shouldSearchStation = false
                }
            ZStack {
                if viewModel.allSettlements == nil {
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
        .customNavigationModifier(router: router, viewModel: viewModel, title: "Выбор Города")
    }
    
    private var SearchBarView: some View {
        SearchBar(searchText: $searchText, isSearching: $isSearching, placeholder: "Введите запрос")
            .padding(.bottom, 16)
            .onChange(of: searchText) { newValue in
                viewModel.searchText = newValue
            }
    }
    
    private var searchResultsStub: some View {
        Text("Город не найден")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var lazyListView: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.filteredSettlements) { city in
                    Button(action: {
                        viewModel.setSelectedCity(city)
                        router.push(.selectStationView)
                        searchText = ""
                    }) {
                        let name = city.title ?? ""
                        ScheduleCellView(cityName: name)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.leading, 18)
                }
            }
        }
    }
}

// MARK: - Previews
#Preview {
    let coordinator = AppCoordinator.shared
    coordinator.setupDependencies()

    return SelectCityView()
}
