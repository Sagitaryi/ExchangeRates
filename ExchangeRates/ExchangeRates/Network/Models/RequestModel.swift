import Foundation

// то что мы отправляем на сервер
// базовая валюта и список валют для конвертации

struct RatesRequestModel {
    let base: SymbolsResponseDTO
    let symbols: SymbolsResponseDTO
}
