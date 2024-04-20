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
 
        guard case let .success(urlRequest) = SymbolsRequestBuilder().makeRequest() else {
            completion(.failure(.request))
            return
        }
        
        networkClient.fetch(request: urlRequest) { (result: Result<SymbolsResponseDTO, NetworkClientError>) in
            switch result {
            case .success(let responseData):
                let model = SymbolsModel(response: responseData)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
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
        request.addValue("tN6XcUKHL2u6REhZf9ZpQleUOiwNPjnP", forHTTPHeaderField: "apikey")
        return .success(request)
    }
}
