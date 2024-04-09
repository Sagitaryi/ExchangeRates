import Foundation

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
