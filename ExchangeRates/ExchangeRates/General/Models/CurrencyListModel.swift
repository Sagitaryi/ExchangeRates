//
//  CurrencyListModel.swift
//  ExchangeRates
//
//  Created by Алексей Чумаков on 16.07.2024.
//

import UIKit

struct CurrencyListModel {
    var rates: [Rates]

    struct Rates {
        let flag: UIImage?
        let key: String?
        let value: String?
        let quantity: Double
        let rate: Double
    }
}
