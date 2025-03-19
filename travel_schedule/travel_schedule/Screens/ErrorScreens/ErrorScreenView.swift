//
//  ErrorScreenView.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 17.03.2025.
//

import SwiftUI

struct ErrorScreenView: View {
    // MARK: Private Properties
    private let error: NetworkError
    private let image: String
    private let label: String
    private let networkMonitor: NetworkMonitor
    // MARK: - States
    @ObservedObject private var router: Router
    
    // MARK: - init
    
    init(error: NetworkError) {
        switch error {
        case .internetConnectError:
            self.image = "networkError"
            self.label = "Нет интернета"
        case .serverError:
            self.image = "serverError"
            self.label = "Ошибка сервера"
        case .requestTimeout:
            self.image = "network.slash"
            self.label = "Непредвиденная ошибка requestTimeout"
        case .unauthorized:
            self.image = "network.slash"
            self.label = "Ошибка авторизации"
        case .notFound:
            self.image = "network.slash"
            self.label = "Непредвиденная ошибка notFound"
        case .genericError:
            self.image = "network.slash"
            self.label = "Непредвиденная ошибка"
        }
        
        guard let r = DIContainer.shared.resolve(Router.self), let networkMonitor = DIContainer.shared.resolve(NetworkMonitor.self) else {
            fatalError("Dependencies not registered")
        }
        self.router = r
        self.networkMonitor = networkMonitor
        self.error = error
        setupNavBarTitle()
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            VStack(alignment: .center, spacing: 16) {
                Image(image)
                Text(label)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.ypBlack)
            }
        }
        .customNavigationModifier(router: router, title: "")
        .onChange(of: networkMonitor.isConnected) { _ in
            if networkMonitor.isConnected && error == .internetConnectError {
                router.pop()
            }
        }
    }
}

#Preview {
    let coordinator = AppCoordinator.shared
    coordinator.setupDependencies()
    
    
    return ErrorScreenView(error: .genericError)
}
