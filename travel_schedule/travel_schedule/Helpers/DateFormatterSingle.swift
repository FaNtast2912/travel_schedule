//
//  DateFormatterSingle.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 17.03.2025.
//

import Foundation

final class DateFormatterSingle {
    static let shared: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    private init() {}
}
