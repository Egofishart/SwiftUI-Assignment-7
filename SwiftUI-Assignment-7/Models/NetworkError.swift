//
//  NetworkError.swift
//  SwiftUI-Assignment-7
//
//  Created by NikoDanelia on 22/10/2026.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case badStatusCode(Int)
    case noData
    case decodingFailed
    case noInternet

    var message: String {
        switch self {
        case .invalidURL: return "არასწორი მისამართი"
        case .badStatusCode(let code): return "სერვერის შეცდომა (კოდი: \(code))"
        case .noData: return "სერვერიდან ცარიელი პასუხი მოვიდა"
        case .decodingFailed: return "მონაცემების დამუშავება ვერ მოხერხდა"
        case .noInternet: return "ინტერნეტთან კავშირი არ არის"
        }
    }

    var icon: String {
        switch self {
        case .noInternet: return "wifi.slash"
        case .badStatusCode: return "server.rack"
        default: return "exclamationmark.triangle"
        }
    }
}
