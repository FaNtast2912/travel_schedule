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
    @StateObject private var viewModel = MainScreenModel()

    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.stationsResult)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
            
            Button(action: {
                viewModel.fetchStations()
            }) {
                Text("Получить резултат")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

// Превью
struct StationsView_Previews: PreviewProvider {
    static var previews: some View {
        StationsView()
    }
}
