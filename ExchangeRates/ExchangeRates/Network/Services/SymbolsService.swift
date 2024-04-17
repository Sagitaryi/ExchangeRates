import Foundation

final class SymbolsRequestBuilder {
    private let endpoint = "symbols"

    fileprivate func makeRequest() -> Result<URLRequest, NetworkClientError> {
        guard let url = URL(string: APIPath.fullPath + endpoint) else {
            return .failure(.request)
        }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("tN6XcUKHL2u6REhZf9ZpQleUOiwNPjnP", forHTTPHeaderField: "apikey")
        return .success(request)
    }
}

protocol SymbolsServiceProtocol {
    func fetchSymbols(completion: @escaping (Result<SymbolsModel, NetworkClientError>) -> ())
}

final class SymbolsService: SymbolsServiceProtocol {
    private let networkClient: NetworkClientProtocol
    private var urlRequest: URLRequest?

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func fetchSymbols(completion: @escaping (Result<SymbolsModel, NetworkClientError>) -> ()) {
        let result = SymbolsRequestBuilder().makeRequest()
        switch result {
        case .success(let request):
            print("request success")
            urlRequest = request
        case .failure(let error):
            completion(.failure(error))
        }

        if let request = urlRequest {
            print("request = urlRequest")
            networkClient.fetch(request: request ) { (result: Result<SymbolsResponseDTO, NetworkClientError>) in
                switch result {
                case .success(let responseData):
                    let model = SymbolsModel.init(response: responseData)
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

//        let arraySymbols = SymbolsModel(symbols: [ "RON": "Romanian Leu",
//                                                   "RSD": "Serbian Dinar",
//                                                   "RUB": "Russian Ruble",
//                                                   "RWF": "Rwandan Franc",
//                                                   "SAR": "Saudi Riyal",
//                                                   "SBD": "Solomon Islands Dollar",
//                                                   "SCR": "Seychellois Rupee",
//                                                   "SDG": "South Sudanese Pound",
//                                                   "SEK": "Swedish Krona"])
//            if true {
//                completion(.success(arraySymbols))
//            } else {
//                completion(.failure(NetworkClientError.empty))
//            }
