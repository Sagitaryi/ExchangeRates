import Foundation

final class RatesDemoService: RatesServiceProtocol {
    func fetchRates(base _: String, symbols _: [String], queue _: DispatchQueue, completion: @escaping (Result<RatesModel, NetworkClientError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(Constants.model))
        }
    }
}

private extension RatesDemoService {
    enum Constants {
        static let base = "RUB"
        static let date = Date()
        static let rates = ["KZT": 5.270347, "USD": 0.010991, "EUR": 0.009807]

        static let model = RatesModel(base: base, date: date, rates: rates)
    }
}
