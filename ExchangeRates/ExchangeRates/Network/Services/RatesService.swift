import Foundation

protocol RatesServiceProtocol {
    func fetchRates(
        base: String,
        symbols: [String],
        completion: @escaping (Result<RatesModel, NetworkClientError>) -> Void
    )
}

final class RatesService: NetworkService, RatesServiceProtocol {
    private var model: RatesModel?

    func fetchRates(
        base: CurrencyId,
        symbols: [CurrencyId],
        completion: @escaping (Result<RatesModel, NetworkClientError>) -> Void
    ) {
        if let model = model {
            completion(.success(model))
        }
        guard case var .success(urlRequest) = RatesRequestBuilder()
            .makeRequest(base: base, symbols: symbols)
        else {
            DispatchQueue.main.async {
                completion(.failure(.request))
            }
            return
        }

        addingTokenToURLRequest(urlRequest: &urlRequest)

        networkClient.fetch(request: urlRequest) { (result: Result<RatesResponseDTO, NetworkClientError>) in
            let ratesModel: Result<RatesModel, NetworkClientError>

            switch result {
            case .success(let data):
                if let model = RatesModel(response: data) {
                    self.model = model
                    ratesModel = .success(model)
                } else {
                    ratesModel = .failure(.incorrectData) // TODO: не вызовется completion, зависнет этот кусок кода тут лучше тогда if let ... else  ...
                }
            case .failure(let error):
                ratesModel = .failure(error)
            }
            DispatchQueue.main.async {
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
