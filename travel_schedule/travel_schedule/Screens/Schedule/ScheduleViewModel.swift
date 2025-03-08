//
//  MainScreenViewModel.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 08.03.2025.
//

import Foundation
import Combine

class ScheduleViewModel: ObservableObject {

    @Published var from: String = ""
    @Published var to: String = ""
    
    @Published var isEditingFromField: Bool = true
    
    func swapLocations() {
        let buffer = from
        from = to
        to = buffer
    }
    
    func setSelectedCity(_ city: String) {
        if isEditingFromField {
            from = city
        } else {
            to = city
        }
    }
}
