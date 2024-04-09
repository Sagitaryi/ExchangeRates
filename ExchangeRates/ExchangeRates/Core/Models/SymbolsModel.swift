import Foundation

struct SymbolsModel {
    let symbols: [String : String]
}

extension SymbolsModel {
    init(response: SymbolsResponseDTO) {
        self.init(symbols: response.symbols)
    }
}
