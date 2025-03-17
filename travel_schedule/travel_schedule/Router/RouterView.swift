//
//  RouterView.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 16.02.2025.
//

import SwiftUI

struct RouterView<Content: View>: View {
    // MARK: - Private Properties
    @ObservedObject private var networkMonitor: NetworkMonitor
    @ObservedObject private var router: Router
    @ObservedObject private var factory: ScreenFactory
    private let content: Content
    
    // MARK: - Initialisers
    @inlinable
    init(@ViewBuilder content: @escaping () -> Content) {
        guard let r = DIContainer.shared.resolve(Router.self),
              let f = DIContainer.shared.resolve(ScreenFactory.self),
              let networkMonitor = DIContainer.shared.resolve(NetworkMonitor.self)
        else {
            fatalError("Dependencies not registered")
        }
        self.content = content()
        self.router = r
        self.factory = f
        self.networkMonitor = networkMonitor
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .overlay(
                    Group {
                        if !networkMonitor.isConnected {
                            factory.view(for: .networkErrorView)
                                .transition(.opacity)
                        }
                    }
                )
                .navigationDestination(for: Router.Route.self) {
                    factory.view(for: $0)
                }
        }
    }
}

// MARK: - Расширение чтобы свайп работал
extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
