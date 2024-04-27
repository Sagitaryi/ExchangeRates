import Foundation

class NetworkService {
    let networkClient: NetworkClientProtocol
    let token = TokenProvider()

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func updateURLRequest(urlRequest: inout URLRequest) {
        token.injectToken(urlRequest: &urlRequest)
    }
}
