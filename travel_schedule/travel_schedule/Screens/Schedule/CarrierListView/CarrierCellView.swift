//
//  CarrierCellView.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 15.03.2025.
//

import SwiftUI

struct CarrierCardView: View {
    
    private let segment: Segment
    private let startDate: String
    private let departureTime: String
    private let arrivalTime: String
    private let travelTime: Double
    
    init(segment: Segment, startDate: String, departureTime: String, arrivalTime: String) {
        self.segment = segment
        travelTime = Double((segment.duration ?? 0)/3600)
        self.startDate = startDate
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
    }
    var body: some View {
        ZStack {
            Color.ypLightGray
            VStack(spacing: 14) {
                carrierInfo
                depatureInfo
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
    
    private var carrierLogo: some View {
        AsyncImage(url: URL(string: segment.thread?.carrier?.logo ?? "")) { phase in
            switch phase {
            case .failure:
                Image(systemName: "photo")
                    .font(.largeTitle)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
            default:
                ProgressView()
            }
        }
        .frame(width: 38, height: 38)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var carrierNameAndTransfersInfo: some View {
        VStack(alignment: .leading) {
            Text(segment.thread?.carrier?.title ?? "информации нет")
                .font(.system(size: 17, weight: .regular))
            Text("C пересадкой в: \(segment.transfers?.first?.title ?? "")")
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(Color.ypRed)
                .lineLimit(2)
                .opacity( segment.hasTransfers ?? false ? 1 : 0)
        }
    }
    
    private var depatureInfo: some View {
        HStack {
            Text(departureTime)
            separator
            Text("\(travelTime, specifier: "%.0f") часов")
                .font(.system(size: 12, weight: .regular))
            separator
            Text(arrivalTime)
        }
        .foregroundStyle(.ypBlackConstant)
    }
    
    private var carrierInfo: some View {
        HStack(alignment: .top, spacing: 18) {
            carrierLogo
            carrierNameAndTransfersInfo
            Spacer()
            Text(startDate)
                .font(.system(size: 12, weight: .regular))
        }
        .foregroundStyle(Color.ypBlackConstant)
    }
    
    
    private var separator: some View {
        Rectangle()
            .foregroundStyle(.ypGray)
            .frame(height: 1)
    }
}


#Preview {
    let from = SearchStation(
        type: "station",
        title: "Москва (Восточный вокзал)",
        shortTitle: nil,
        popularTitle: nil,
        code: nil,
        lat: 0,
        lng: 0,
        stationType: "train_station",
        transportType: "train",
        distance: nil,
        majority: nil,
        direction: nil,
        codes: Codes(
            yandexCode: nil,
            esrCode: nil
        )
    )
    let to = SearchStation(
        type: "station",
        title: "Санкт-Петербург (Московский вокзал)",
        shortTitle: nil,
        popularTitle: nil,
        code: nil,
        lat: 0,
        lng: 0,
        stationType: "train_station",
        transportType: "train",
        distance: nil,
        majority: nil,
        direction: nil,
        codes: Codes(
            yandexCode: nil,
            esrCode: nil
        ))
    let ticketInfo = TicketsInfo(
        etMarker: false,
        places: [Place(name: "", price: Price(currency: "", whole: 0, cents: 0))]
    )
    let segment: Segment = .init(from: from, to: to, departure: Date(), arrival: Date(), thread: nil, ticketsInfo: ticketInfo, duration: 0, transfers: [], hasTransfers: true)
    CarrierCardView(segment: segment, startDate: "", departureTime: "", arrivalTime: "")
}
