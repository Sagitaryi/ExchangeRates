import Foundation

struct CurrenciesReceived: Codable {
    let date: Date
    let symbols: SymbolsModel
}

// extension CurrenciesReceived {
//    init(date: Date, symbols: [CurrencyId: String]) {
//
//    }
// }
