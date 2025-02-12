//
//  ErrorCollector.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 12.02.2025.


actor ErrorCollector {
    private(set) var errors: [Error] = []
    
    func addError(_ error: Error) {
        errors.append(error)
    }
    
    func getAllErrors() -> [Error] {
        return errors
    }
}
