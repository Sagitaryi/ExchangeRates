import Foundation


typealias CurrencyId = String // "EUR", "RUB" ...

struct SymbolsModel {
    let symbols: [CurrencyId: String]
}

extension SymbolsModel {
    init(response: SymbolsResponseDTO) {
        self.init(symbols: response.symbols)
    }
}
