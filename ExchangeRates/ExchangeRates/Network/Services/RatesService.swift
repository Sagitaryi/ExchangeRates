import Foundation

final class RatesRequestBuilder {
//    final class SymbolsRequestBuilder {
        private let endpoint = "latest"
        private let 

        func makeRequest() -> Result<URLRequest, NetworkClientError> {
            guard let url = URL(string: APIPath.fullPath + endpoint) else {
                return .failure(.request)
            }
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

    }
}
