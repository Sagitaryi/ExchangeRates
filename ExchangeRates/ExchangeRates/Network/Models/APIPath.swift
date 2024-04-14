import Foundation

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
    enum APIPath {
        static let hostURL = "https://api.apilayer.com/"
        static let URL = "exchangerates_data/"
    }

//    enum Endpoints: String {
//        case symbols
//        case rates = "latest"
//    }
}
