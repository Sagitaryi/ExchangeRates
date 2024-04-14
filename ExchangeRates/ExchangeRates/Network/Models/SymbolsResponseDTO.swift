import Foundation

struct SymbolsResponseDTO: Decodable {
    let success: Bool
    let symbols: [String : String]
}
