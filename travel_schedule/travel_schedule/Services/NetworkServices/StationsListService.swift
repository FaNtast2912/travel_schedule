//
//  StationsListService.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 11.02.2025.
//

import Foundation

typealias StationsList = Components.Schemas.AllStationsResponse

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
        let response = try await client.getAllStations(query: .init(apikey: apikey))
        let sequence = try response.ok.body.text_html_charset_utf_hyphen_8
        let data = try await Data(collecting: sequence, upTo: 40 * 1024 * 1024)
        let allStations = try JSONDecoder().decode(StationsList.self, from: data)
        return allStations
    }
}
