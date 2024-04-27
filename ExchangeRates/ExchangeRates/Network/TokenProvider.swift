import Foundation

protocol TokenProviderProtocol {
    func injectToken(urlRequest: inout URLRequest)
}

final class TokenProvider: TokenProviderProtocol {
    private static let apiKey = "tN6XcUKHL2u6REhZf9ZpQleUOiwNPjnP"

    func injectToken(urlRequest: inout URLRequest) {
        urlRequest.addValue(TokenProvider.apiKey, forHTTPHeaderField: "apikey")
    }
}

// TODO: можно сделать еще константы так:

private extension TokenProvider {
    enum Constants {
        static let ...
    }
}
