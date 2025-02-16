//
//  ContentView.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 15.02.2025.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        Group {
            if isActive {
                RouterView {
                    ContentView()
                }
            } else {
                SplashView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isActive = true
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    SplashScreenView()
}
#endif
