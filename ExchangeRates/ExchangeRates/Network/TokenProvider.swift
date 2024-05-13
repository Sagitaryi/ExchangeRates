import Foundation

protocol TokenProviderProtocol {
    func injectToken(urlRequest: inout URLRequest)
}

final class TokenProvider: TokenProviderProtocol {
    func injectToken(urlRequest: inout URLRequest) {
        urlRequest.addValue(Constants.apiKey, forHTTPHeaderField: Constants.httpHeader)
    }
}

private extension TokenProvider {
    enum Constants {
        static let apiKey = "tN6XcUKHL2u6REhZf9ZpQleUOiwNPjnP"
        static let httpHeader = "apikey"
    }
}
