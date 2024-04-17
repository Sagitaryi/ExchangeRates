import Foundation

struct RatesResponseDTO: Decodable {
    let base: String
    let date: String
    let rates: [String: Double]
    let success: Bool
    let timestamp: Int
}
