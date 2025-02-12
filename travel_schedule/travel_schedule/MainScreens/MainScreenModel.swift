//
//  MainScreenModel.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 11.02.2025.
//
import Foundation
import OpenAPIURLSession

final class MainScreenModel: ObservableObject {
    
    private let service = TravelServiceFacade.shared
    
    @Published var isLoading = false
    @Published var isSuccess: Bool? = nil
    @Published var errorMessage: String?
    
    func fetchAllData() async {
        await MainActor.run {
            isLoading = true
            isSuccess = nil
            errorMessage = nil
        }
        
        let errorCollector = ErrorCollector()
        
        let methods: [() async throws -> Void] = [
            fetchCarrier,
            fetchCopyright,
            fetchNearestSettlement,
            fetchNearestStations,
            fetchScheduleBetweenStations,
            fetchScheduleOnStation,
            fetchStationList,
            fetchThreadStations
        ]
        
        await withTaskGroup(of: Void.self) { group in
            for method in methods {
                group.addTask {
                    do {
                        try await method()
                    } catch {
                        await errorCollector.addError(error)
                    }
                }
            }
        }
        
        let errors = await errorCollector.getAllErrors()
        
        await MainActor.run {
            isLoading = false
            isSuccess = errors.isEmpty
            errorMessage = errors.isEmpty ? nil : "Произошло \(errors.count) ошибок"
        }
    }
    
    func fetchCarrier() async throws {
        _ = try await service.getCarrier(code: "680")
    }
    
    func fetchCopyright() async throws {
        _ = try await service.getCopyright()
    }
    
    func fetchNearestSettlement() async throws {
        _ = try await service.getNearestSettlement(lat: 59.864177, lng: 30.319163, distance: 50)
    }
    
    func fetchNearestStations() async throws {
        _ = try await service.getNearestStations(lat: 59.864177, lng: 30.319163, distance: 50)
    }
    
    func fetchScheduleBetweenStations() async throws {
        _ = try await service.getScheduleBetweenStations(from: "s9600213", to: "c146", transportTypes: "train", date: "2025-04-10")
    }
    
    func fetchScheduleOnStation() async throws {
        _ = try await service.getScheduleOnStation(station: "s9600213", transportTypes: "train", date: "2025-04-10")
    }
    
    func fetchStationList() async throws {
        _ = try await service.getStationsList()
    }
    
    func fetchThreadStations() async throws {
        _ = try await service.getThreadStation(uid: "068S_2_2")
    }
}
