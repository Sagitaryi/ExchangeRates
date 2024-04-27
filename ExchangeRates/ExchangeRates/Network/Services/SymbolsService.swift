import Foundation

protocol SymbolsServiceProtocol {
    func fetchSymbols(completion: @escaping (Result<SymbolsModel, NetworkClientError>) -> Void)
}

final class SymbolsService: NetworkService, SymbolsServiceProtocol {
    private var model: SymbolsModel?

    private func processCompletion(value: Result<SymbolsModel, NetworkClientError>, completion: @escaping (Result<SymbolsModel, NetworkClientError>) -> Void) {
        DispatchQueue.main.async {
            completion(value)
        }
    }

    func fetchSymbols(completion: @escaping (Result<SymbolsModel, NetworkClientError>) -> Void) {
        if let model = model {
            completion(.success(model))
        }
        guard case var .success(urlRequest) = SymbolsRequestBuilder().makeRequest() else {
            processCompletion(value: .failure(.request), completion: completion)
            return
        }

        updateURLRequest(urlRequest: &urlRequest)

        networkClient.fetch(request: urlRequest) { (result: Result<SymbolsResponseDTO, NetworkClientError>) in
            switch result {
            case let .success(responseData):
                guard let model = SymbolsModel(response: responseData) else {
                    // TODO: вот так лучше не делать, ты в метод  fetchSymbols еще и self затягиваешь ... ради одного DispatchQueue.main.async  - грузно получается.
                    self.processCompletion(value: .failure(.incorrectData), completion: completion)
                    return
                }
                self.model = model
                self.processCompletion(value: .success(model), completion: completion)
            case let .failure(error):
                self.processCompletion(value: .failure(error), completion: completion)
            }
        }
    }
}

final class SymbolsRequestBuilder {
    private let endpoint = "symbols"

    private func makeURL() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.apilayer.com"
        components.path = "/exchangerates_data/\(endpoint)"

        return components.url
    }

    fileprivate func makeRequest() -> Result<URLRequest, NetworkClientError> {
        guard let url = makeURL() else {
            return .failure(.request)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return .success(request)
    }
}
