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
struct Settlement {
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
