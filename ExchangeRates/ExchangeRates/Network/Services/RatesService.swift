import Foundation


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
        base: CurrencyId,
        symbols: [CurrencyId],
        completion: @escaping (Result<RatesModel, NetworkClientError>) -> ()
    ) {
        guard case let .success(urlRequest) = RatesRequestBuilder()
            .makeRequest(base: base, symbols: symbols) else {
            DispatchQueue.main.async {
                completion(.failure(.request))
            }
            return
        }

        networkClient.fetch(request: urlRequest) { (result: Result<RatesResponseDTO, NetworkClientError>) in
            
            let r: Result<RatesModel, NetworkClientError>
            
            switch result {
            case .success(let data):
                r = .success(RatesModel(response: data))
            case .failure(let error):
                r = .failure(error)
            }
            DispatchQueue.main.async {
                completion(r)
            }
        }
    }
}


final class RatesRequestBuilder {
    private let endpoint = "latest"

    private func makeURL(base: String, symbols: [String]) -> URL? {
        
        let symbolsParam = symbols.joined(separator: ",")
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.apilayer.com"
        components.path = "/exchangerates_data/\(endpoint)"
        components.queryItems = [
            URLQueryItem(name: "symbols", value: symbolsParam),
            URLQueryItem(name: "base", value: base)
        ]

        return components.url
    }

    fileprivate func makeRequest(base: String, symbols: [String]) -> Result<URLRequest, NetworkClientError> {
        let url = makeURL(base: base, symbols: symbols)
        guard let url = url else {
            return .failure(.request)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("tN6XcUKHL2u6REhZf9ZpQleUOiwNPjnP", forHTTPHeaderField: "apikey")

        return .success(request)
    }
}

