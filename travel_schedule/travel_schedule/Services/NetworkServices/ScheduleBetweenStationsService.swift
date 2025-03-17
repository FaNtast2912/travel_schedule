//
//  ScheduleBetweenStationsService.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 11.02.2025.
//

//getScheduleBetweenStations

import Foundation
import OpenAPIRuntime

typealias Search = Components.Schemas.Segments

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
        do {
            let response = try await client.getSchedualBetweenStations(
                query: .init(
                    apikey: apikey,
                    from: startStation,
                    to: endStation,
                    date: date,
                    transport_types: transportTypes,
                    transfers: true
                )
            )
            return try response.ok.body.json
        } catch {
            throw mapError(error)
        }
        
    }
    
    private func mapError(_ error: Error) -> NetworkError {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet, .networkConnectionLost:
                return .internetConnectError
            case .timedOut:
                return .requestTimeout
            default:
                return .genericError
            }
        }
        
        if let clientError = error as? ClientError {
            if let response = clientError.response {
                let statusCode = response.status.code
                switch statusCode {
                case 401:
                    return .unauthorized
                case 404:
                    return .notFound
                case 500...599:
                    return .serverError(code: statusCode)
                default:
                    return .genericError
                }
            }
            return .genericError
        }
        
        return .genericError
    }
}
