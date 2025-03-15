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
        ZStack() {
            Background
            HStack(spacing: 16.0) {
                Textfields
                Button(action: {
                    viewModel.fetchStationList()
                    viewModel.swapLocations()
                })
                {
                    ChangeButtonView
                }
            }
        }
        .onAppear {
            
        }
    }
}

// MARK: - Subviews
private extension ScheduleView {
    private var Background: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(Color(.ypBlue))
            .frame(width: 343, height: 128)
    }
    
    private var Textfields: some View {
        VStack(spacing: 28.0) {
            TextField("from", text: $viewModel.from, prompt: Text("Откуда"))
                .padding(.trailing, 13)
                .padding(.leading, 16)
                .padding(.top, 14)
                .disabled(true)
                .overlay(
                    Rectangle()
                        .fill(Color.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.isEditingFromField = true
                            router.push(.selectCityView)
                        }
                )
            TextField("to", text: $viewModel.to, prompt: Text("Куда"))
                .padding(.trailing, 13)
                .padding(.leading, 16)
                .padding(.bottom, 14)
                .disabled(true) // Отключает редактирование
                .overlay(
                    Rectangle()
                        .fill(Color.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.isEditingFromField = false
                            router.push(.selectCityView)
                        }
                )
        }
        .frame(width: 259, height: 96)
        .background(Color.white)
        .cornerRadius(20)
    }
    
    private var ChangeButtonView: some View {
        ZStack() {
            Circle()
                .foregroundColor(Color(.ypWhite))
            Image("change")
                .resizable()
                .foregroundColor(.ypBlue)
                .frame(width: 24, height: 24)
        }
        .frame(width: 36, height: 36)
    }
}

    // MARK: - Previews
struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        let coordinator = AppCoordinator()
        coordinator.setupDependencies()
        
        return coordinator.start()
    }
}

struct ScheduleViewPreviewOnly_Previews: PreviewProvider {
    static var previews: some View {
        let coordinator = AppCoordinator()
        coordinator.setupDependencies()
        
        return ScheduleView()
    }
}
