//
//  SplashScreenView.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 15.02.2025.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Image(.splashScreen)
                .resizable()
                .foregroundColor(.white)
                .ignoresSafeArea(edges: .all)
        }
        .transition(.opacity)
    }
}

#if DEBUG
#Preview {
    SplashView()
}
#endif
