//
//  NetworkError.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 17.03.2025.
//
import Foundation

enum NetworkError: Error, LocalizedError {
    case serverError
    case internetConnectError
    case requestTimeout
    case unauthorized
    case notFound
    case genericError
    
    var errorDescription: String? {
        switch self {
        case .internetConnectError:
            return "Нет подключения к интернету"
        case .serverError:
            return "Ошибка сервера"
        case .requestTimeout:
            return "Таймаут запроса"
        case .unauthorized:
            return "Требуется авторизация"
        case .notFound:
            return "Ресурс не найден"
        default:
            return "Произошла ошибка"
        }
    }
}
