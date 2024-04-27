import Foundation

struct RatesModel {
    let base: CurrencyId
    let date: Date
    let rates: [CurrencyId: Double]
}

extension RatesModel {
    init?(response: RatesResponseDTO) {
        guard response.success else { return nil }
        guard let date = DateFormatter.DDMMYYYYHHMM.date(from: response.date) else { return nil }

        self.init(base: response.base, date: date, rates: response.rates)
    }
}
