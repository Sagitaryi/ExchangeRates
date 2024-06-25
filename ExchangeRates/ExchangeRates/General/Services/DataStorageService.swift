//
//  DataStorageService.swift
//  ExchangeRates
//
//  Created by Алексей Чумаков on 24.06.2024.
//

import Foundation

protocol DataStorageServiceProtocol {
    func storeDefaultData(value: Encodable, key: String)
}

final class DataStorageService: DataStorageServiceProtocol {
    func storeDefaultData(value: Encodable, key: String) {
        UserDefaults.standard.set(encodable: value, forKey: key)
    }

//    func getDefaultData() {
//        UserDefaults.standard.value(<#T##type: Decodable.Protocol##Decodable.Protocol#>, forKey: <#T##String#>)
//    }
}
