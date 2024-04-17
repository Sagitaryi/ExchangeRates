import Foundation

struct RatesModel {
    let base: CurrencyId
    let date: Date // DateTime !!! Парсинг !!!
    let rates: [CurrencyId : Double]
    var errorGettingDate: String?
}

extension RatesModel {
    init(response: RatesResponseDTO) {
        func castingDate() -> (Date, String?) {
            var date = Date()
            var error: String?
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = TimeZone.autoupdatingCurrent
            if let result = dateFormatter.date(from: response.date) {
                date = result
            } else {
                error = """
                        Alert: Failed to get the exchange rate update date.
                        Exchange rates may not be accurate. Try the request again.
                        """
            }
            return (date, error)
        }
        self.init(base: response.base, date: castingDate().0, rates: response.rates, errorGettingDate: castingDate().1)
    }
}
