import Foundation

struct RatesModel {
    let base: CurrencyId
    let date: String // DateTime !!! Парсинг !!!
    let rates: [CurrencyId : Double]
}

extension RatesModel {
    init(response: RatesResponseDTO) {
        self.init(base: response.base, date: response.date, rates: response.rates)
    }
}
