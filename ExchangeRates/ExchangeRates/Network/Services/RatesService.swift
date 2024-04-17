import Foundation

final class RatesRequestBuilder {
    private let endpoint = "latest"
    
    private func get(outputCurrencies: [CurrencyId]) -> CurrencyId {
        var result: CurrencyId = ""
        for currency in outputCurrencies {
            if currency == outputCurrencies.first {
                result = currency
            } else {
                result = ("\(result)%2C\(currency)")
            }
        }
        return result
    }
    
    fileprivate func makeRequest(base: String,
                                 symbols: [String]) -> Result<URLRequest, NetworkClientError> {
        guard let url = URL(string: ("\(APIPath.fullPath)\(endpoint)?symbols=\(get(outputCurrencies: symbols))&base=\(base)")) else {
            return .failure(.request)
        }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("tN6XcUKHL2u6REhZf9ZpQleUOiwNPjnP", forHTTPHeaderField: "apikey")
        
        return .success(request)
        
    }
}

protocol RatesServiceProtocol {
    func fetchRates(
        base: String,
        symbols: [String],
        completion: @escaping (Result<RatesModel, NetworkClientError>) -> ()
    )
}

final class RatesService: RatesServiceProtocol {

    private let networkClient: NetworkClientProtocol
    private var urlRequest: URLRequest?

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func fetchRates(
        base: String,
        symbols: [String],
        completion: @escaping (Result<RatesModel, NetworkClientError>) -> ()
    ) {

        let result = RatesRequestBuilder().makeRequest(base: base, symbols: symbols)
        switch result {
        case .success(let request):
            urlRequest = request
        case .failure(let error):
            completion(.failure(error))
        }

        if let request = urlRequest{
            networkClient.fetch(request: request) { (result: Result<RatesResponseDTO, NetworkClientError>) in
                switch result {
                case .success(let data):
                    let model = RatesModel(response: data)
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
