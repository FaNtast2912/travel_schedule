//
//  CloseButton.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 18.03.2025.
//

import SwiftUI

struct CloseButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(.close)
        }
    }
}



#Preview {
    CloseButton(action: {})
}
