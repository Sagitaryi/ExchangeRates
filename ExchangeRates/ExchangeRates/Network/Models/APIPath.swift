import Foundation

enum APIPath {
    static let host = "https://api.apilayer.com/"
    static let path = "exchangerates_data/"
    static var fullPath: String { host + path }
}


//enum HTTPMethodType: String {
//    case get = "GET"
//    case head = "HEAD"
//    case post    = "POST"
//    case put     = "PUT"
//    case patch   = "PATCH"
//    case delete  = "DELETE"
//}

//final class APIPath {
//    private let baseURL = "https://api.apilayer.com/exchangerates_data/"
//
//    func fullPath(endpoint: Endpoints) -> URL? {
//        guard let url = URL(string: "\(baseURL)\(endpoint)") else { return nil }
//        return url
//    }
//

//struct Kfu {
//    let lk: Endpoints
//
//    enum Endpoints: String {
//        case symbols
//        case latest
//    }
//}
//
//let dfj = Kfu(lk: .latest)

//    enum Endpoints: String {
//        case symbols
//        case rates = "latest"
//    }
//}
