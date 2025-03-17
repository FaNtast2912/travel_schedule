//
//  ScheduleOnStationService.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 11.02.2025.
//
import Foundation
import OpenAPIRuntime

typealias Schedule = Components.Schemas.ScheduleResponse

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
        do {
            let response = try await client.getStationSchedule(
                query: .init(
                    apikey: apikey,
                    station: station,
                    date: date,
                    transport_types: transportTypes
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
