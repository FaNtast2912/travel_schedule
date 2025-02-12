//
//  ContentView.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 09.02.2025.
//

import SwiftUI
import OpenAPIURLSession

// View
struct MainScreen: View {
    @StateObject private var model = MainScreenModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Load All Data") {
                Task {
                    await model.fetchAllData()
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            if model.isLoading {
                ProgressView()
                    .scaleEffect(2)
            } else if model.isSuccess == true {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.system(size: 60))
            } else if model.isSuccess == false {
                VStack {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                        .font(.system(size: 60))
                    Text(model.errorMessage ?? "Unknown error")
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
        }
        .padding()
        .animation(.default, value: model.isLoading)
    }
}

// Превью
struct StationsView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
