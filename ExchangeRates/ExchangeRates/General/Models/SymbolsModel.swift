import Foundation

typealias CurrencyId = String // "EUR", "RUB" ...

struct SymbolsModel: Codable {
    let symbols: [CurrencyId: String]
}

extension SymbolsModel {
    init?(response: SymbolsResponseDTO) {
        guard response.success else {
            return nil
        }
        self.init(symbols: response.symbols)
    }
}
