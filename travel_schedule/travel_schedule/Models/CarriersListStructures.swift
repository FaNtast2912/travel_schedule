//
//  CarriersListStructures.swift
//  travel_schedule
//
//  Updated by Maksim Zakharov on 15.03.2025.
//
import Foundation

// MARK: - Root structure
struct SegmentsResponse {
    let pagination: Pagination?
    let segments: [Segment?]?
}

// MARK: - Pagination
struct Pagination {
    let total: Int?
    let limit: Int?
    let offset: Int?
}

// MARK: - Segment
struct Segment: Identifiable {
    let id = UUID()
    let from: SearchStation
    let to: SearchStation
    let departure: Date?
    let arrival: Date?
    let thread: ThreadInfo?
    let ticketsInfo: TicketsInfo
    let duration: Int?
    let transfers: [Transfers]?
    let hasTransfers: Bool?
}

// MARK: - Transfers
struct Transfers {
    let title: String
    let code: String?
}

// MARK: - SearchStation
struct SearchStation: Identifiable {
    let id = UUID()
    let type: String
    let title: String
    let shortTitle: String?
    let popularTitle: String?
    let code: String?
    let lat: Double
    let lng: Double
    let stationType: String
    let transportType: String
    let distance: Double?
    let majority: Int?
    let direction: String?
    let codes: Codes
}

// MARK: - Codes
struct Codes {
    let yandexCode: String?
    let esrCode: String?
}

// MARK: - Thread
struct ThreadInfo {
    let uid: String
    let title: String
    let number: String
    let carrier: CarrierInfo?
    let transportType: String
    let vehicle: String?
    let startTime: String
    let days: String?
    let interval: Interval?
}

// MARK: - Carrier
struct CarrierInfo {
    let code: Int
    let contacts: String?
    let url: String?
    let title: String
    let phone: String?
    let address: String?
    let logo: String?
    let email: String?
    let codes: CarrierCodes?
}

// MARK: - CarrierCodes
struct CarrierCodes {
    let icao: String?
    let sirena: String?
    let iata: String?
}

// MARK: - TicketsInfo
struct TicketsInfo {
    let etMarker: Bool
    let places: [Place]
}

// MARK: - Place
struct Place {
    let name: String
    let price: Price
}

// MARK: - Price
struct Price {
    let currency: String
    let whole: Int
    let cents: Int
}

// MARK: - Interval
struct Interval {
    let density: String
    let beginTime: Date?
    let endTime: Date?
}

// MARK: - Convert extension
extension SegmentsResponse {
    static func from(apiResponse: Components.Schemas.Segments) -> SegmentsResponse {
        let pagination = Pagination.from(apiPagination: apiResponse.pagination)
        let segments = apiResponse.segments.flatMap { $0.map { Segment.from(apiSegment: $0) }}
        return SegmentsResponse(pagination: pagination, segments: segments)
    }
}

extension Pagination {
    static func from(apiPagination: Components.Schemas.Pagination?) -> Pagination? {
        guard let apiPagination else { return nil }
        return Pagination(
            total: apiPagination.total,
            limit: apiPagination.limit,
            offset: apiPagination.offset
        )
    }
}

extension Segment {
    static func from(apiSegment: Components.Schemas.Segment) -> Segment? {
        let formatter = ISO8601DateFormatter()
        guard let fromStation = apiSegment.from, let toStation = apiSegment.to else {
            return nil
        }
        return Segment(
            from: SearchStation.from(apiStation: fromStation),
            to: SearchStation.from(apiStation: toStation),
            departure: apiSegment.departure,
            arrival: apiSegment.arrival,
            thread: ThreadInfo.from(apiThread: apiSegment.thread),
            ticketsInfo: TicketsInfo.from(apiTicketsInfo: apiSegment.tickets_info),
            duration: apiSegment.duration,
            transfers: apiSegment.transfers?.map { Transfers.from(apiTransfer: $0) },
            hasTransfers: apiSegment.has_transfers
        )
    }
}

extension Transfers {
    static func from(apiTransfer: Components.Schemas.Transfers) -> Transfers {
        return Transfers(
            title: apiTransfer.title ?? "",
            code: apiTransfer.code
        )
    }
}

extension SearchStation {
    static func from(apiStation: Components.Schemas.Station) -> SearchStation {
        let codes = Codes(
            yandexCode: apiStation.codes?.yandex_code,
            esrCode: apiStation.codes?.esr_code
        )
        
        return SearchStation(
            type: apiStation._type ?? "",
            title: apiStation.title ?? "",
            shortTitle: apiStation.short_title,
            popularTitle: apiStation.popular_title,
            code: apiStation.code,
            lat: apiStation.lat ?? 0.0,
            lng: apiStation.lng ?? 0.0,
            stationType: apiStation.station_type ?? "",
            transportType: apiStation.transport_type ?? "",
            distance: apiStation.distance,
            majority: apiStation.majority,
            direction: apiStation.direction,
            codes: codes
        )
    }
}

extension ThreadInfo {
    static func from(apiThread: Components.Schemas.Thread?) -> ThreadInfo? {
        guard let apiThread = apiThread else {
            return nil
        }
        return ThreadInfo(
            uid: apiThread.uid ?? "",
            title: apiThread.title ?? "",
            number: apiThread.number ?? "",
            carrier: Carrier.from(apiCarrier: apiThread.carrier),
            transportType: apiThread.transport_type ?? "",
            vehicle: apiThread.vehicle,
            startTime: apiThread.start_time ?? "",
            days: apiThread.days,
            interval: Interval.from(apiInterval: apiThread.interval)
        )
    }
}

extension Carrier {
    static func from(apiCarrier: Components.Schemas.Carrier?) -> CarrierInfo? {
        guard let apiCarrier = apiCarrier else {
            return nil
        }
        let codes = CarrierCodes(
            icao: apiCarrier.codes?.icao,
            sirena: apiCarrier.codes?.sirena,
            iata: apiCarrier.codes?.iata
        )
        
        return CarrierInfo(
            code: apiCarrier.code ?? 0,
            contacts: apiCarrier.contacts,
            url: apiCarrier.url,
            title: apiCarrier.title ?? "",
            phone: apiCarrier.phone,
            address: apiCarrier.address,
            logo: apiCarrier.logo,
            email: apiCarrier.email,
            codes: codes
        )
    }
}

extension TicketsInfo {
    static func from(apiTicketsInfo: Components.Schemas.TicketsInfo?) -> TicketsInfo {
        guard let apiTicketsInfo = apiTicketsInfo else {
            return TicketsInfo(etMarker: false, places: [])
        }
        
        return TicketsInfo(
            etMarker: apiTicketsInfo.et_marker ?? false,
            places: apiTicketsInfo.places?.map { Place.from(apiPlace: $0) } ?? []
        )
    }
}

extension Place {
    static func from(apiPlace: Components.Schemas.Place) -> Place {
        Place(
            name: apiPlace.name ?? "",
            price: Price.from(apiPrice: apiPlace.price)
        )
    }
}

extension Price {
    static func from(apiPrice: Components.Schemas.Price?) -> Price {
        Price(
            currency: apiPrice?.currency ?? "",
            whole: apiPrice?.whole ?? 0,
            cents: apiPrice?.cents ?? 0
        )
    }
}

extension Interval {
    static func from(apiInterval: Components.Schemas.Interval?) -> Interval? {
        guard let apiInterval = apiInterval else { return nil }
        let formatter = ISO8601DateFormatter()
        
        return Interval(
            density: apiInterval.density ?? "",
            beginTime: apiInterval.begin_time,
            endTime: apiInterval.end_time
        )
    }
}
