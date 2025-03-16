//
//  TreadStationsService.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 11.02.2025.
//

typealias Thread = Components.Schemas.ThreadStationsResponse

protocol TreadStationsServiceProtocol {
    func getThreadStations(uid: String) async throws -> Thread
}

final class TreadStationsService: TreadStationsServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getThreadStations(uid: String) async throws -> Thread {
        let response = try await client.getRouteStations(
            query: .init(
                apikey: apikey,
                uid: uid
            )
        )
        return try response.ok.body.json
    }
}
