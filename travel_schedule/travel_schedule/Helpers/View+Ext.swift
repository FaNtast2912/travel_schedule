//
//  View+Ext+NavBar.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 14.03.2025.
//

import SwiftUI
// Nav bar setup
extension View {
    func setupNavBarTitle() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .ypWhite
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 17, weight: .bold)]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

// MARK: - List Modify

struct CustomNavigationModifier: ViewModifier {
    let router: Router
    let viewModel: ScheduleViewModel
    let title: String
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        router.pop()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                }
            }
            .onAppear {
                if viewModel.allSettlements == nil {
                    viewModel.fetchStationList()
                }
            }
    }
}

extension View {
    func customNavigationModifier(router: Router, viewModel: ScheduleViewModel, title: String) -> some View {
        self.modifier(CustomNavigationModifier(router: router, viewModel: viewModel, title: title))
    }
}


