import Foundation

final class RatesRequestBuilder {
    private let endpoint = "latest"

    private func get(outputCurrencies: [CurrencyId]) -> CurrencyId {
        return outputCurrencies.joined(separator: ",")
    }

    private func makeURL(base: String,
                         symbols: [String]) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.apilayer.com"
        components.path = "/exchangerates_data/\(endpoint)"
        components.queryItems = [
            URLQueryItem(name: "symbols", value: get(outputCurrencies: symbols)),
            URLQueryItem(name: "base", value: base)
        ]

        return components.url
    }

    fileprivate func makeRequest(base: String,
                                 symbols: [String]) -> Result<URLRequest, NetworkClientError> {
        let url = makeURL(base: base, symbols: symbols)
        guard let url = url else {
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

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func fetchRates(
        base: String,
        symbols: [String],
        completion: @escaping (Result<RatesModel, NetworkClientError>) -> ()
    ) {
        guard case let .success(urlRequest) = RatesRequestBuilder()
            .makeRequest(base: base, symbols: symbols) else {
            return completion(.failure(.request))
        }

        networkClient.fetch(request: urlRequest) { (result: Result<RatesResponseDTO, NetworkClientError>) in
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


