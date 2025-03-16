//
//  SearchButton.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 15.03.2025.
//

import SwiftUI

struct SearchButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Найти")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 150, height: 60)
                .background(Color.ypBlue)
                .cornerRadius(16)
        }
    }
}

#Preview {
    SearchButton(action: {})
}
