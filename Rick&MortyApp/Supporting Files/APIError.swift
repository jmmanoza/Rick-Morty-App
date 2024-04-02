//
//  APIError.swift
//  Rick&MortyApp
//
//  Created by jmmanoza on 4/2/24.
//

import Foundation

enum APIError: LocalizedError {
    
    case invalidURL
    case invalidResponse
    case invalidData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid url found."
        case .invalidResponse:
            return "Invalid response found."
        case .invalidData:
            return "Invalid data found."
        }
    }
}
