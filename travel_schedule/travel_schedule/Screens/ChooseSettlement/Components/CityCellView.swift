//
//  CityCellView.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 13.03.2025.
//

import SwiftUI

struct CityCellView: View {
    
    @State var cityName: String
    
    var body: some View {
        HStack(spacing: 4.0) {
            Text(cityName)
                .foregroundStyle(Color.ypBlack)
                .font(.system(size: 17, weight: .light, design: .default))
            Spacer()
            Image(systemName: "chevron.right")
            .foregroundStyle(.ypBlack)
            .padding(.vertical, 18)
            .padding(.trailing, 18)
            .frame(width: 24, height: 24)
        }
        .frame(width: .infinity, height: 60)
        .background(Color.white)
    }

}

#Preview {
    Rectangle()
        .frame(width: .infinity, height: .infinity)
        .ignoresSafeArea(.all)
        .overlay(
            CityCellView(cityName: "Мурманск")
        )
}
