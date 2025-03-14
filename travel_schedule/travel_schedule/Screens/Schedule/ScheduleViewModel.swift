//
//  MainScreenViewModel.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 08.03.2025.
//

import Foundation
import Combine

final class ScheduleViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var from: String = ""
    @Published var to: String = ""
    @Published var selectedStartCity: Settlement?
    @Published var selectedEndCity: Settlement?
    @Published var selectedStartStation: Station?
    @Published var selectedEndStation: Station?
    @Published var allSettlements: [Settlement]?
    @Published var isEditingFromField: Bool = true
    @Published var searchText: String = ""
    @Published private(set) var filteredSettlements: [Settlement] = []
    
    // MARK: - Private Properties
    private var networkService: TravelServiceFacade
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init() {
        guard let networkService = DIContainer.shared.resolve(TravelServiceFacade.self) else {
            fatalError("Dependencies not registered")
        }
        self.networkService = networkService
        
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.filterCities(by: text)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Public Methods
    func swapLocations() {
        swapText()
        swapSelectedCities()
    }
    
    
    func setSelectedCity(_ city: Settlement) {
        if isEditingFromField {
            from = city.title ?? ""
            selectedStartCity = city
        } else {
            to = city.title ?? ""
            selectedEndCity = city
        }
    }
    
    func fetchStationList() {
        Task {
            do {
                let stationList = try await networkService.getStationsList()
                guard let countries = stationList.countries,
                      let russia = countries.first(where: { $0.title == "Россия" }),
                      let regions = russia.regions else {
                    print("Ошибка: Не найдена страна или регионы в ней")
                    return
                }
                
                let settlements = extractAndSortSettlements(from: regions)
                
                await MainActor.run { [settlements] in
                    allSettlements = settlements
                    filteredSettlements = settlements
                }
                
                for settlement in settlements {
                    print("\(settlement.title ?? ""): \(settlement.stations.count) stations")
                }
            } catch {
                print("Ошибка загрузки станций: \(error.localizedDescription)")
            }
        }
    }
}


// MARK: - Private Methods
// Конвертация и сортировка
private extension ScheduleViewModel {
    func sortSettlements(_ settlements: inout [Settlement]) {
        let priorityCities = [
            "Москва",
            "Санкт-Петербург",
            "Сочи",
            "Мурманск",
            "Краснодар",
            "Казань",
            "Омск"
        ]
        settlements.sort { (a: Settlement, b: Settlement) -> Bool in
            let titleA = a.title ?? ""
            let titleB = b.title ?? ""
            
            if let firstIndex = priorityCities.firstIndex(of: titleA),
               let secondIndex = priorityCities.firstIndex(of: titleB) {
                return firstIndex < secondIndex
            } else if priorityCities.contains(titleA) {
                return true
            } else if priorityCities.contains(titleB) {
                return false
            } else {
                return titleA < titleB
            }
        }
    }
    
    func extractAndSortSettlements(from regions: [Components.Schemas.Region]) -> [Settlement] {
        var settlements: [Settlement] = []
        
        for region in regions {
            for apiSettlement in (region.settlements ?? []) {
                let settlement = convertToSettlement(apiSettlement)
            
                if let title = settlement.title, !title.isEmpty {
                    settlements.append(settlement)
                }
            }
        }
        
        sortSettlements(&settlements)
        return settlements
    }

    
    func convertToStation(_ apiStations: [Components.Schemas.Station]?) -> [Station] {
        let stations = (apiStations ?? []).map { apiStation in
            Station.from(apiStation: apiStation)
        }
        return stations
    }
    
    func convertToSettlement(_ apiSettlement: Components.Schemas.Settlement) -> Settlement {
        let stations = convertToStation(apiSettlement.stations)
        
        return Settlement(
            title: apiSettlement.title,
            codes: apiSettlement.codes != nil ? Codes(yandexCode: apiSettlement.codes?.yandex_code) : nil,
            stations: stations
        )
    }
}

// Внутренняя логика приложения
private extension ScheduleViewModel {
    func swapSelectedCities() {
        let buffer = selectedStartCity
        selectedStartCity = selectedEndCity
        selectedEndCity = buffer
    }
    
    func swapText() {
        let buffer = from
        from = to
        to = buffer
    }
    
    func filterCities(by query: String) {
        guard let settlements = allSettlements else {
            filteredSettlements = []
            return
        }
        
        if query.isEmpty {
            filteredSettlements = settlements.filter { $0.title != nil }
        } else {
            filteredSettlements = settlements.filter { city in
                if let title = city.title?.lowercased(), title.contains(query.lowercased()) {
                    return true
                }
                return city.stations.contains { station in
                    station.title.lowercased().contains(query.lowercased())
                }
            }
        }
    }
}
