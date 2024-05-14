import Foundation

protocol SymbolsServiceProtocol {
    func fetchSymbols(queue: DispatchQueue, completion: @escaping (Result<SymbolsModel, NetworkClientError>) -> Void)
}

final class SymbolsService: NetworkService, SymbolsServiceProtocol {
    private var model: SymbolsModel?

    func fetchSymbols(queue: DispatchQueue = .main, completion: @escaping (Result<SymbolsModel, NetworkClientError>) -> Void) {
        if let model = model {
            completion(.success(model))
        }
        guard case var .success(urlRequest) = SymbolsRequestBuilder().makeRequest() else {
            queue.async {
                completion(.failure(.request))
            }
            return
        }

        addingTokenToURLRequest(urlRequest: &urlRequest)

        networkClient.fetch(request: urlRequest) { (result: Result<SymbolsResponseDTO, NetworkClientError>) in
            let symbolsModel: Result<SymbolsModel, NetworkClientError>

            switch result {
            case let .success(responseData):
                if let model = SymbolsModel(response: responseData) {
                    self.model = model
                    symbolsModel = .success(model)
                } else {
                    symbolsModel = .failure(.incorrectData)
                }
            case let .failure(error):
                symbolsModel = .failure(error)
            }
            queue.async {
                completion(symbolsModel)
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
