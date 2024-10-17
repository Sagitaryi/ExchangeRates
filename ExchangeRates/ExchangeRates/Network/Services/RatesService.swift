import Foundation

protocol RatesServiceProtocol {
    func fetchRates(
        base: String,
        symbols: [String],
        queue: DispatchQueue,
        completion: @escaping (Result<RatesModel, NetworkClientError>) -> Void
    )
}

final class RatesService: NetworkService, RatesServiceProtocol {
    func fetchRates(
        base: CurrencyId,
        symbols: [CurrencyId],
        queue: DispatchQueue = .main,
        completion: @escaping (Result<RatesModel, NetworkClientError>) -> Void
    ) {
        guard case var .success(urlRequest) = RatesRequestBuilder()
            .makeRequest(base: base, symbols: symbols)
        else {
            queue.async {
                completion(.failure(.request))
            }
            return
        }

        addingTokenToURLRequest(urlRequest: &urlRequest)

        networkClient.fetch(request: urlRequest) { (result: Result<RatesResponseDTO, NetworkClientError>) in
            let ratesModel: Result<RatesModel, NetworkClientError>

            switch result {
            case let .success(data):
                if let model = RatesModel(response: data) {
                    ratesModel = .success(model)
                } else {
                    ratesModel = .failure(.incorrectData)
                }
            case let .failure(error):
                ratesModel = .failure(error)
            }
            queue.async {
                completion(ratesModel)
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
            URLQueryItem(name: "base", value: base),
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

        return .success(request)
    }
}
