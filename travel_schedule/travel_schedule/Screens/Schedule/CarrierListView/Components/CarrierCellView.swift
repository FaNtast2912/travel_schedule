//
//  CarrierCellView.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 15.03.2025.
//

import SwiftUI

struct CarrierCellView: View {
    // MARK: - Private Properties
    private let segment: Segment
    
    // MARK: - init
    init(segment: Segment) {
        self.segment = segment
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
                    .scaledToFit()
            default:
                ProgressView()
            }
        }
        .frame(width: 38, height: 38)
        .clipped()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        
    }
    
    private var carrierNameAndTransfersInfo: some View {
        VStack(alignment: .leading) {
            Text(segment.thread?.carrier?.title ?? "информации нет")
                .font(.system(size: 17, weight: .regular))
            Text("C пересадкой в: \(segment.transfers.first?.title ?? "")")
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(Color.ypRed)
                .lineLimit(2)
                .opacity( segment.hasTransfers ? 1 : 0)
        }
    }
    
    private var depatureInfo: some View {
        HStack {
            Text(segment.departure ?? "")
            separator
            Text(segment.duration ?? "")
                .font(.system(size: 12, weight: .regular))
            separator
            Text(segment.arrival ?? "")
        }
        .foregroundStyle(.ypBlackConstant)
    }
    
    private var carrierInfo: some View {
        HStack(alignment: .top, spacing: 18) {
            carrierLogo
            carrierNameAndTransfersInfo
            Spacer()
            Text(segment.startDate ?? "")
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
