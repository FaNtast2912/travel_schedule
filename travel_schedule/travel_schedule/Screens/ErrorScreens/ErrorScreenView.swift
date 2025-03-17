//
//  ErrorScreenView.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 17.03.2025.
//

import SwiftUI

enum NetworkError: Error, LocalizedError {
    case serverError
    case internetConnectError
    case requestTimeout
    case unauthorized
    case notFound
    case genericError
    
    var errorDescription: String? {
        switch self {
        case .internetConnectError:
            return "Нет подключения к интернету"
        case .serverError:
            return "Ошибка сервера"
        case .requestTimeout:
            return "Таймаут запроса"
        case .unauthorized:
            return "Требуется авторизация"
        case .notFound:
            return "Ресурс не найден"
        default:
            return "Произошла ошибка"
        }
    }
}

struct ErrorScreenView: View {
    // MARK: Private Properties
    private let image: String
    private let label: String
    
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
        
        guard let r = DIContainer.shared.resolve(Router.self) else {
            fatalError("Dependencies not registered")
        }
        self.router = r
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
    }
}

#Preview {
    let coordinator = AppCoordinator()
    coordinator.setupDependencies()
    
    
    return ErrorScreenView(error: .genericError)
}
