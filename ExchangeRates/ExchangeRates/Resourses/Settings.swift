//
//  Settings.swift
//  ExchangeRates
//
//  Created by Алексей Чумаков on 23.08.2024.
//

import Foundation

enum Settings {
    static var soldCurrency = "RUB"
    static let purchasedCurrencyList = ["EUR", "USD", "KZT"]

    static let rateDecimals = "4"
    static let amountDecimals = "2"

//    static var soldCurrency: String {
//        let currency = "RUB"
//
//        return currency
//    }

//    // keychain ids
//    static let keychainChippingAddressID = "com.vnazimko.fashion.store.chipping.address"
//    static let keychainPaymentMethodID = "com.vnazimko.fashion.store.payment.method"
}
