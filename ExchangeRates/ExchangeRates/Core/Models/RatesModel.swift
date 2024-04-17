import Foundation

struct RatesModel {
    let base: CurrencyId
    let date: Date // DateTime !!! Парсинг !!!
    let rates: [CurrencyId : Double]
}

extension RatesModel {
    init(response: RatesResponseDTO) {
        var date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        if let result = dateFormatter.date(from: response.date) {
            date = result
        } else {
            print("""
                  Alert: Failed to get the exchange rate update date.
                  Exchange rates may not be accurate. Try the request again.
""")
        }
        self.init(base: response.base, date: date, rates: response.rates)
    }
}
