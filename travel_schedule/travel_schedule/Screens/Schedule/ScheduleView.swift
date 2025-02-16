//
//  ScheduleView.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 16.02.2025.
//

import SwiftUI

struct ScheduleView: View {
    @EnvironmentObject private var router: Router
    
    var body: some View {
        VStack {
            Text("Root view")
            Button(action: { router.push(.firstView) }) {
                Text("Go to first view")
            }
            Button(action: { router.push(.storiesView) }) {
                Text("Go to Scroll view")
            }
        }
    }
}

#Preview {
    ScheduleView()
}
