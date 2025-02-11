//
//  MainScreenModel.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 11.02.2025.
//
import Foundation
import OpenAPIURLSession

class MainScreenModel: ObservableObject {
    @Published var stationsResult: String = "Нажмите кнопку для получения данных"

    @MainActor
    func fetchStations() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = NearestSettlementService(
            client: client,
            apikey: "7e385f73-a617-47a7-9f00-9c84898bf886"
        )

        Task {
            do {
                let stations = try await service.getNearestSettlement(lat: 59.864177, lng: 30.319163, distance: 50)
                self.stationsResult = "Станции: \(stations)"
            } catch {
                self.stationsResult = "Ошибка: \(error.localizedDescription)"
            }
        }
    }
}
