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
    
    
    @MainActor
    func fetchCarier() {
        Task {
            do {
                let carier = try await service.getCarrier(code: "S7")
            } catch {
                print("Ошибка: \(error.localizedDescription) in fetchCarier")
            }
        }
    }
    
    @MainActor
    func fetchCopyright() {
        Task {
            do {
                let copyright = try await service.getCopyright()
            } catch {
                print("Ошибка: \(error.localizedDescription) in fetchCopyright")
            }
        }
    }
    
    @MainActor
    func fetchNearestSettlement() {
        Task {
            do {
                let nearestSettlement = try await service.getNearestSettlement(lat: 59.864177, lng: 30.319163, distance: 50)
            } catch {
                print("Ошибка: \(error.localizedDescription) in fetchNearestSettlement")
            }
        }
    }
    
    @MainActor
    func fetchNearestStations() {
        Task {
            do {
                let stations = try await service.getNearestStations(lat: 59.864177, lng: 30.319163, distance: 50)
            } catch {
                print("Ошибка: \(error.localizedDescription) in fetchNearestStations")
            }
        }
    }
    
    @MainActor
    func fetchScheduleBetweenStations() {
        Task {
            do {
                let schedule = try await service.getScheduleBetweenStations(from: "MOW", to: "LED", transportTypes: "", date: "")
            } catch {
                print("Ошибка: \(error.localizedDescription) in fetchScheduleBetweenStations")
            }
        }
    }
    
    @MainActor
    func fetchScheduleOnStation() {
        Task {
            do {
                let schedule = try await service.getScheduleOnStation(station: "MOW", transportTypes: "", date: "")
            } catch {
                print("Ошибка: \(error.localizedDescription) in fetchScheduleOnStation")
            }
        }
    }
    
    @MainActor
    func fetchTreadStations() {
        Task {
            do {
                let stations = try await service.getThreadStation(uid: "1234567890")
            } catch {
                print("Ошибка: \(error.localizedDescription) in fetchTreadStations")
            }
        }
    }
}
