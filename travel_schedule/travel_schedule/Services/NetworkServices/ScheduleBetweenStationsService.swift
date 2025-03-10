//
//  ScheduleBetweenStationsService.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 11.02.2025.
//

//getScheduleBetweenStations

typealias Search = Components.Schemas.Search

protocol ScheduleBetweenStationsServiceProtocol {
    func getScheduleBetweenStations(from: String, to: String, transportTypes: String, date: String) async throws -> Search
}

final class ScheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getScheduleBetweenStations(from startStation: String, to endStation: String, transportTypes: String, date: String) async throws -> Search {
        let response = try await client.getScheduleBetweenStations(
            query: .init(
                apikey: apikey,
                from: startStation,
                to: endStation,
                date: date,
                transport_types: transportTypes
            )
        )
        return try response.ok.body.json
    }
}
