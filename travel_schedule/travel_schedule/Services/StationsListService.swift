//
//  StationsListService.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 11.02.2025.
//

typealias StationsList = Components.Schemas.StationsList

protocol StationsListServiceProtocol {
    func getStationsList() async throws -> StationsList
}

final class StationsListService: StationsListServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getStationsList() async throws -> StationsList {
        let response = try await client.getStationsList(
            query: .init(
                apikey: apikey
            )
        )
        return try response.ok.body.json
    }
}
