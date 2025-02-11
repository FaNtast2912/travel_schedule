//
//  CarrierService.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 11.02.2025.
//
import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias Carrier = Components.Schemas.Carrier

class CarrierService {
    private let client: Client
    private let apikey: String
    private let code: String
    
    init(client: Client, apikey: String, code: String) {
        self.client = client
        self.apikey = apikey
        self.code = code
    }
    
    func performRequest() async throws -> Any {
        let result = try await client.getCarrier(query: .init(apikey: <#T##String#>, code: <#T##String#>))
        return result
    }
}
