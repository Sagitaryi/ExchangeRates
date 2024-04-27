import Foundation

class NetworkService {
    let networkClient: NetworkClientProtocol // TODO: private нужно скрыть от изменения
    let token = TokenProvider()              // TODO: private

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func updateURLRequest(urlRequest: inout URLRequest) { // TODO: я бы тут более понятное название сделал, например updateToken и тп
        token.injectToken(urlRequest: &urlRequest)
    }
}