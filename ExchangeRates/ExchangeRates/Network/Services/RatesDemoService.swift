//
//  RatesDemoService.swift
//  ExchangeRates
//
//  Created by Алексей Чумаков on 25.08.2024.
//

import Foundation

final class RatesDemoService: RatesServiceProtocol {
    func fetchRates(base _: String, symbols _: [String], queue _: DispatchQueue, completion: @escaping (Result<RatesModel, NetworkClientError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(Constants.model))
        }
    }
}

private extension RatesDemoService {
    enum Constants {
        static let base = "RUB"
        static let date = Date()
        static let rates = ["KZT": 5.270347, "USD": 0.010991, "EUR": 0.009807]

        static let model = RatesModel(base: base, date: date, rates: rates)
    }
}

// {
//  "base": "EUR",
//  "date": "2024-08-25",
//  "rates": {
//    "PAB": 1.111912,
//    "PHP": 63.056332,
//    "RUB": 101.971956,
//    "USD": 1.120762
//  },
//  "success": true,
//  "timestamp": 1724593744
//

// model RatesModel(base: "RUB", date: 2024-08-24 17:00:00 +0000, rates: ["KZT": 5.270347, "USD": 0.010991, "EUR": 0.009807])
