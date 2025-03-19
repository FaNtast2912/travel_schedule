//
//  TreadStationsService.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 11.02.2025.
//
import Foundation
import OpenAPIRuntime

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
        do {
            let response = try await client.getRouteStations(
                query: .init(
                    apikey: apikey,
                    uid: uid
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
                    return .serverError
                default:
                    return .genericError
                }
            }
            return .genericError
        }
        
        return .genericError
    }
}
