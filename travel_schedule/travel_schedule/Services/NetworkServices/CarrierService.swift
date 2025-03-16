//
//  CarrierService.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 11.02.2025.
//
import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias Carrier = Components.Schemas.CarrierResponse

protocol CarrierServiceProtocol {
    func getCarrier(code: String) async throws -> Carrier
}

final class CarrierService: CarrierServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCarrier(code: String) async throws -> Carrier {
        let response = try await client.getCarrierInfo(
            query: .init(
                apikey: apikey,
                code: code
            )
        )
        return try response.ok.body.json
    }
}

