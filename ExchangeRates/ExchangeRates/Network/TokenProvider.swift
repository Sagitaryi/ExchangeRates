//
//  TokenProvider.swift
//  ExchangeRates
//
//  Created by Dmitriy Mirovodin on 20.04.2024.
//

import Foundation

protocol TokenProviderProtocol {
    
    func injectToken(urlRequest: inout URLRequest)
}

final class TokenProvider: TokenProviderProtocol {
    
    private static let apiKey = "tN6XcUKHL2u6REhZf9ZpQleUOiwNPjnP"
    
    func injectToken(urlRequest: inout URLRequest) {
        urlRequest.addValue(TokenProvider.apiKey, forHTTPHeaderField: "apikey")
    }
}
