//
//  MainScreenViewModel.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 08.03.2025.
//

import Foundation
import Combine

class MainScreenViewModel: ObservableObject {

    @Published var from: String = ""
    @Published var to: String = ""
    

    func swapLocations() {
        let buffer = from
        from = to
        to = buffer
    }
}
