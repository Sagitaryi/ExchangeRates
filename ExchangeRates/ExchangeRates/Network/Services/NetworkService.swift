import Foundation

class NetworkService {
    
    let networkClient: NetworkClientProtocol
    
    private let token = TokenProvider()

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func addingTokenToURLRequest(urlRequest: inout URLRequest) {
        token.injectToken(urlRequest: &urlRequest)
    }
}
