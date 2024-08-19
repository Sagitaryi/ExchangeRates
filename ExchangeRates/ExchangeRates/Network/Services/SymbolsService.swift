import Foundation

protocol SymbolsServiceProtocol {
    func fetchSymbols(queue: DispatchQueue, completion: @escaping (Result<SymbolsModel, NetworkClientError>) -> Void)
}

final class SymbolsService: NetworkService, SymbolsServiceProtocol {
    private let keyStoredUserDefault = "currenciesReceived"

    func fetchSymbols(queue: DispatchQueue = .main, completion: @escaping (Result<SymbolsModel, NetworkClientError>) -> Void) {
        if let currenciesReceived = UserDefaults.standard.value(CurrenciesReceived.self, forKey: keyStoredUserDefault) {
            if Calendar.current.isDateInToday(currenciesReceived.date) {
                queue.async {
                    completion(.success(currenciesReceived.symbols))
                    print("Get data from UserDefault")
                }
                return
            }
        }
        print("Get data from API")

        guard case var .success(urlRequest) = SymbolsRequestBuilder().makeRequest() else {
            queue.async {
                completion(.failure(.request))
            }
            return
        }

        addingTokenToURLRequest(urlRequest: &urlRequest)

        networkClient.fetch(request: urlRequest) { [self] (result: Result<SymbolsResponseDTO, NetworkClientError>) in
            let symbolsModel: Result<SymbolsModel, NetworkClientError>

            switch result {
            case let .success(responseData):
                if let model = SymbolsModel(response: responseData) {
                    let currenciesReceived: CurrenciesReceived = .init(date: Date(), symbols: model)
                    storeDefaultData(value: currenciesReceived, key: keyStoredUserDefault)
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

extension SymbolsService: DataStorageServiceProtocol {
    func storeDefaultData(value: Encodable, key: String) {
        DataStorageService().storeDefaultData(value: value, key: key)
    }
}
