//
//  MainScreenModel.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 11.02.2025.
//
import Foundation
import OpenAPIURLSession

class MainScreenModel: ObservableObject {
    
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
            fetchCarier,
            fetchCopyright,
            fetchNearestSettlement,
            fetchNearestStations,
            fetchScheduleBetweenStations,
            fetchScheduleOnStation,
            fetchStationList,
            fetchTreadStations
        ]
        
        await withTaskGroup(of: Void.self) { group in
            for method in methods {
                group.addTask {
                    do {
                        try await method()
                    } catch {
                        await errorCollector.addError(error)
                        print("Ошибка в методе: \(error.localizedDescription)")
                    }
                }
            }
            
            await group.waitForAll()
        }
        
        let errors = await errorCollector.getAllErrors()
        
        await MainActor.run {
            isLoading = false
            isSuccess = errors.isEmpty
            errorMessage = errors.isEmpty ? nil : errors.map { $0.localizedDescription }.joined(separator: "\n")
            print("Количество ошибок: \(errors.count)")
            if !errors.isEmpty {
                print("Ошибки: \(errors)")
            }
        }
    }
    
    @MainActor
    func fetchCarier() async throws {
        Task {
            do {
                let carier = try await service.getCarrier(code: "680")
            } catch {
                print("Ошибка: \(error.localizedDescription) in fetchCarier")
            }
        }
    }
    
    @MainActor
    func fetchCopyright() async throws {
        Task {
            do {
                let copyright = try await service.getCopyright()
            } catch {
                print("Ошибка: \(error.localizedDescription) in fetchCopyright")
            }
        }
    }
    
    @MainActor
    func fetchNearestSettlement() async throws {
        Task {
            do {
                let nearestSettlement = try await service.getNearestSettlement(lat: 59.864177, lng: 30.319163, distance: 50)
            } catch {
                print("Ошибка: \(error.localizedDescription) in fetchNearestSettlement")
            }
        }
    }
    
    @MainActor
    func fetchNearestStations() async throws {
        Task {
            do {
                let stations = try await service.getNearestStations(lat: 59.864177, lng: 30.319163, distance: 50)
            } catch {
                print("Ошибка: \(error.localizedDescription) in fetchNearestStations")
            }
        }
    }
    
    @MainActor
    func fetchScheduleBetweenStations() async throws {
        Task {
            do {
                let schedule = try await service.getScheduleBetweenStations(from: "s9600213", to: "c146", transportTypes: "train", date: "2025-04-10")
            } catch {
                print("Ошибка: \(error.localizedDescription) in fetchScheduleBetweenStations")
            }
        }
    }
    
    @MainActor
    func fetchScheduleOnStation() async throws {
        Task {
            do {
                let schedule = try await service.getScheduleOnStation(station: "s9600213", transportTypes: "train", date: "2025-04-10")
            } catch {
                print("Ошибка: \(error.localizedDescription) in fetchScheduleOnStation")
            }
        }
    }
    
    @MainActor
    func fetchStationList() async throws {
        Task {
            do {
                let stations = try await service.getStationsList()
            } catch {
                print("Ошибка: \(error.localizedDescription) in fetchStationList")
            }
        }
    }
    
    @MainActor
    func fetchTreadStations() async throws {
        Task {
            do {
                let stations = try await service.getThreadStation(uid: "068S_2_2")
            } catch {
                print("Ошибка: \(error.localizedDescription) in fetchTreadStations")
            }
        }
    }
}
