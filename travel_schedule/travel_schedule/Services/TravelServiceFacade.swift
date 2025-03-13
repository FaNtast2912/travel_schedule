//
//  TravelServiceFacade.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 11.02.2025.
//
import SwiftUI
import OpenAPIURLSession

protocol NetworkClientProtocol: ObservableObject {
    var carrierService: CarrierServiceProtocol { get }
    var copyrightService: CopyrightServiceProtocol { get }
    var nearestSettlementService: NearestSettlementServiceProtocol { get }
    var nearestStationsService: NearestStationsServiceProtocol { get }
    var scheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol { get }
    var scheduleOnStationService: ScheduleOnStationServiceProtocol { get }
    var stationsListService: StationsListServiceProtocol { get }
    var treadStationsService: TreadStationsServiceProtocol { get }

    func getCarrier(code: String) async throws -> Carrier
    
    func getCopyright() async throws -> Copyright
    
    func getNearestSettlement(lat: Double, lng: Double, distance: Int) async throws -> NearestSettlement

    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
    
    func getScheduleBetweenStations(from startStation: String, to endStation: String, transportTypes: String, date: String) async throws -> Search
    
    func getScheduleOnStation(station: String, transportTypes: String, date: String) async throws -> Schedule
    
    func getStationsList() async throws -> StationsList
    
    func getThreadStation(uid: String) async throws -> Thread
}

final class TravelServiceFacade: NetworkClientProtocol {

    let carrierService: CarrierServiceProtocol
    let copyrightService: CopyrightServiceProtocol
    let nearestSettlementService: NearestSettlementServiceProtocol
    let nearestStationsService: NearestStationsServiceProtocol
    let scheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol
    let scheduleOnStationService: ScheduleOnStationServiceProtocol
    let stationsListService: StationsListServiceProtocol
    let treadStationsService: TreadStationsServiceProtocol

    init(client: Client, apikey: String) {
        self.carrierService = CarrierService(client: client, apikey: apikey)
        self.copyrightService = CopyrightService(client: client, apikey: apikey)
        self.nearestSettlementService = NearestSettlementService(client: client, apikey: apikey)
        self.nearestStationsService = NearestStationsService(client: client, apikey: apikey)
        self.scheduleBetweenStationsService = ScheduleBetweenStationsService(client: client, apikey: apikey)
        self.scheduleOnStationService = ScheduleOnStationService(client: client, apikey: apikey)
        self.stationsListService = StationsListService(client: client, apikey: apikey)
        self.treadStationsService = TreadStationsService(client: client, apikey: apikey)
    }
    
    convenience init() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        let apikey = "7e385f73-a617-47a7-9f00-9c84898bf886"
        self.init(client: client, apikey: apikey)
    }

    func getCarrier(code: String) async throws -> Carrier {
        return try await carrierService.getCarrier(code: code)
    }
    
    func getCopyright() async throws -> Copyright {
        return try await copyrightService.getCopyright()
    }
    
    func getNearestSettlement(lat: Double, lng: Double, distance: Int) async throws -> NearestSettlement {
        return try await nearestSettlementService.getNearestSettlement(lat: lat, lng: lng, distance: distance)
    }

    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        return try await nearestStationsService.getNearestStations(lat: lat, lng: lng, distance: distance)
    }
    
    func getScheduleBetweenStations(from startStation: String, to endStation: String, transportTypes: String, date: String) async throws -> Search {
        return try await scheduleBetweenStationsService.getScheduleBetweenStations(from: startStation, to: endStation, transportTypes: transportTypes, date: date)
    }
    
    func getScheduleOnStation(station: String, transportTypes: String, date: String) async throws -> Schedule {
        return try await scheduleOnStationService.getScheduleOnStation(station: station, transportTypes: transportTypes, date: date)
    }
    
    func getStationsList() async throws -> StationsList {
        return try await stationsListService.getStationsList()
    }
    
    func getThreadStation(uid: String) async throws -> Thread {
        return try await treadStationsService.getThreadStations(uid: uid)
    }
}
