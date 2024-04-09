import Foundation

struct RatesModel {
    let base: String
    let date: String
    let rates: [String : Double]
}

extension RatesModel {
    init(response: RatesResponseDTO) {
        self.init(base: response.base, date: response.date, rates: response.rates)
    }
}
