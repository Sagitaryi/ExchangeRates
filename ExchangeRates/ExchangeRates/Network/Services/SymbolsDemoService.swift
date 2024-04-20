import Foundation

protocol SymbolsDemoServiceProtocol {
    func fetchSymbols(completion: @escaping (Result<SymbolsModel, NetworkClientError>) -> ())
}

final class SymbolsDemoService: SymbolsDemoServiceProtocol {

    func fetchSymbols(completion: @escaping (Result<SymbolsModel, NetworkClientError>) -> ()) {
        completion(.success(Constants.model))
    }
}

private extension SymbolsDemoService {
    
    enum Constants {
        
        static let symbols: [CurrencyId: String] = [
            "RON": "Romanian Leu",
            "RSD": "Serbian Dinar",
            "RUB": "Russian Ruble",
            "RWF": "Rwandan Franc",
            "SAR": "Saudi Riyal",
            "SBD": "Solomon Islands Dollar",
            "SCR": "Seychellois Rupee",
            "SDG": "South Sudanese Pound",
            "SEK": "Swedish Krona"
        ]
                
        static let model = SymbolsModel(symbols: symbols)
    }
}
