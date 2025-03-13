//
//  StationsListStructures.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 11.02.2025.
//

import Foundation

// MARK: - Root structure
struct Response {
    let countries: [Country]
}

// MARK: - Country structure
struct Country {
    let title: String
    let codes: Codes
    let region: Region
}

// MARK: - Codes structure
struct Codes {
    let yandexCode: String?
}

// MARK: - Region structure
struct Region {
    let title: String?
    let codes: Codes?
    let settlement: Settlement?
}

// MARK: - Settlement structure
struct Settlement: Identifiable {
    let id = UUID()
    let title: String?
    let codes: Codes?
    let stations: [Station]
}

// MARK: - Station structure
struct Station {
    let title: String
    let longitude: Double
    let latitude: Double
    let transportType: String
    let stationType: String
    let direction: String?
    let codes: Codes
}

// MARK: - Convert extension

extension Settlement {
    static func from(apiSettlement: Components.Schemas.Settlement) -> Settlement {
        let codes: Codes? = apiSettlement.codes?.yandex_code != nil ?
            Codes(yandexCode: apiSettlement.codes?.yandex_code) : nil
        
        let stations = (apiSettlement.stations ?? []).map { apiStation in
            Station.from(apiStation: apiStation)
        }
        
        return Settlement(
            title: apiSettlement.title,
            codes: codes,
            stations: stations
        )
    }
}

extension Station {
    static func from(apiStation: Components.Schemas.Station) -> Station {
        let codes: Codes? = apiStation.code != nil ?
            Codes(yandexCode: apiStation.code) : nil
        
        return Station(
            title: apiStation.title ?? "",
            longitude: apiStation.lng ?? 0,
            latitude: apiStation.lat ?? 0,
            transportType: apiStation.transport_type ?? "",
            stationType: apiStation.station_type ?? "",
            direction: apiStation.direction,
            codes: codes ?? Codes(yandexCode: "")
        )
    }
}
