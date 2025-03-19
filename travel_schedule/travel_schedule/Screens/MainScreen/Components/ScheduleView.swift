//
//  ScheduleView.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 07.03.2025.
//

import SwiftUI

struct ScheduleView: View {
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
        VStack(spacing: 16.0) {
            ZStack() {
                Background
                HStack(spacing: 16) {
                    Textfields
                    Button(action: {
                        viewModel.fetchStationList()
                        viewModel.swapLocations()
                    })
                    {
                        ChangeButtonView
                    }
                    .contentShape(Circle())
                    .frame(width: 36, height: 36)
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 32)
            }
            if viewModel.shouldSearchCarriers {
                SearchButton {
                    viewModel.fetchSegments()
                    router.push(.carriersListView)
                }
            }
        }
    }
}

// MARK: - Subviews
private extension ScheduleView {
    private var Background: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(Color(.ypBlue))
            .frame(height: 128)
            .padding(.horizontal, 16)
    }
    
    private var Textfields: some View {
        VStack(alignment: .leading) {
            getSelectDestinationView(text: viewModel.from, placeholder: "Откуда")
                .onTapGesture {
                    viewModel.isEditingFromField = true
                    router.push(.selectCityView)
                }
            
            getSelectDestinationView(text: viewModel.to, placeholder: "Куда")
                .onTapGesture {
                    viewModel.isEditingFromField = false
                    router.push(.selectCityView)
                }
        }
        .frame(height: 96)
        .font(.system(size: 17, weight: .regular))
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.ypWhiteConstant)
        )
    }
    
    private var ChangeButtonView: some View {
        ZStack() {
            Circle()
                .foregroundColor(Color(.ypWhiteConstant))
            Image("change")
                .resizable()
                .foregroundColor(.ypBlue)
                .frame(width: 24, height: 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    func getSelectDestinationView(text: String, placeholder: String) -> some View {
        ZStack(alignment: .leading) {
            Color.ypWhiteConstant
            Text(text.isEmpty ? placeholder : text)
                .padding(.vertical, 14)
                .padding([.leading], 16)
                .lineLimit(1)
                .foregroundStyle(!text.isEmpty ? .ypBlackConstant : .ypGray)
        }
        .cornerRadius(20)
    }
}

// MARK: - Previews
struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        let coordinator = AppCoordinator.shared
        coordinator.setupDependencies()
        
        return coordinator.start()
    }
}

struct ScheduleViewPreviewOnly_Previews: PreviewProvider {
    static var previews: some View {
        let coordinator = AppCoordinator.shared
        coordinator.setupDependencies()
        
        return ScheduleView()
    }
}
