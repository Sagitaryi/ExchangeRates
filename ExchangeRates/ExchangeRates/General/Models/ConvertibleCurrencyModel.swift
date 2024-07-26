//
//  ConvertibleCurrencyModel.swift
//  ExchangeRates
//
//  Created by Алексей Чумаков on 15.07.2024.
//

import UIKit

struct ConvertibleCurrencyModel {
    let flag: UIImage?
    let key: String?
    let value: String?
    let sum: Double?
    let rate: Double?

    init(model: SymbolsModel) {
        flag = UIImage(named: model.symbols.keys.first!)
        key = model.symbols.keys.first
        value = model.symbols.values.first
        sum = 1
        rate = 2
    }
}
