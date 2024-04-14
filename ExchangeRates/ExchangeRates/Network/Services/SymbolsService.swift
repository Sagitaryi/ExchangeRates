import Foundation

final class SymbolsRequestBuilder {
    private let baseURL = "https://api.apilayer.com/exchangerates_data/"
    private let endpoint = "symbols"

    func request() -> Result<URLRequest, Error> {
        let url = APIPath()
        url.fullPath(endpoint: .symbols)
        guard let url = URL(string: APIPath.shared.) else {
            return .failure(NetworkClientError.request)
        }
        var request = URLRequest(url: APIPath.shared.fullPath(endpoint: .symbols) )
        request.httpMethod = "GET"
        request.addValue("tN6XcUKHL2u6REhZf9ZpQleUOiwNPjnP", forHTTPHeaderField: "apikey")

        return request
    }
}



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
