//
//  ScheduleOnStationService.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 11.02.2025.
//

typealias Schedule = Components.Schemas.Schedule

protocol ScheduleOnStationServiceProtocol {
    func getScheduleOnStation(station: String, transportTypes: String, date: String) async throws -> Schedule
}

final class ScheduleOnStationService: ScheduleOnStationServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func  getScheduleOnStation(station: String, transportTypes: String, date: String) async throws -> Schedule {
        let response = try await client.getScheduleOnStation(
            query: .init(
                apikey: apikey,
                station: station,
                date: date,
                transport_types: transportTypes
            )
        )
        return try response.ok.body.json
    }
}
