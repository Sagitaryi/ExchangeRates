import Foundation

protocol SymbolsServiceProtocol {
    func fetchSymbols(completion: @escaping (Result<SymbolsModel, NetworkClientError>) -> ())
}

final class SymbolsService: SymbolsServiceProtocol {

        private let networkClient: NetworkClientProtocol

        init(networkClient: NetworkClientProtocol) {
            self.networkClient = networkClient
        }

        func fetchSymbols(completion: @escaping (Result<SymbolsModel, NetworkClientError>) -> ()) {


            let arraySymbols = SymbolsModel(symbols: [ "RON": "Romanian Leu",
                                                       "RSD": "Serbian Dinar",
                                                       "RUB": "Russian Ruble",
                                                       "RWF": "Rwandan Franc",
                                                       "SAR": "Saudi Riyal",
                                                       "SBD": "Solomon Islands Dollar",
                                                       "SCR": "Seychellois Rupee",
                                                       "SDG": "South Sudanese Pound",
                                                       "SEK": "Swedish Krona"])
            if true {
                completion(.success(arraySymbols))
            } else {
                completion(.failure(NetworkClientError.empty))
            }
        }
}
