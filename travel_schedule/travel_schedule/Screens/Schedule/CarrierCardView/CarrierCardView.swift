//
//  CarrierCardView.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 17.03.2025.
//

import SwiftUI

struct CarrierCardView: View {
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
                VStack(alignment: .leading) {
                    carrierLogo
                    carrierInfo
                    Spacer()
                        .toolbarRole(.editor)
                        .navigationTitle("Информация о перевозчике")
                }
                .foregroundStyle(.ypBlack)
                .padding(16)
            }
            .customNavigationModifier(router: router, viewModel: viewModel, title: "Информация о перевозчике")
        }
    
    private var carrierLogo: some View {
        AsyncImage(url: URL(string: viewModel.selectedCarrier?.logo ?? "")) { phase in
            switch phase {
            case .failure:
                Image(systemName: "photo")
                    .font(.largeTitle)
                    .foregroundStyle(.ypBlackConstant)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            default:
                Image(systemName: "photo")
                    .font(.largeTitle)
                    .foregroundStyle(.ypBlackConstant)
            }
        }
        .frame(width: 343, height: 104)
        .background(.ypWhiteConstant)
        .clipShape(.rect(cornerRadius: 24))
    }
    
    
    private var carrierInfo: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(viewModel.selectedCarrier?.title ?? "информации нет")
                .font(.system(size: 24, weight: .bold))
            VStack(alignment: .leading, spacing: 0) {
                Text("E-mail")
                    .font(.system(size: 17, weight: .regular))
                Text(viewModel.selectedCarrier?.email ?? "информации нет")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.ypBlue)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Телефон")
                    .font(.system(size: 17, weight: .regular))
                Text(viewModel.selectedCarrier?.phone ?? "информации нет")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.ypBlue)
            }
        }
    }
}

#Preview {
    CarrierCardView()
}
