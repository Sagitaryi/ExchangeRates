import Foundation

enum APIPath {
    static let host = "https://api.apilayer.com/"
    static let path = "exchangerates_data/"
    static var fullPath: String { host + path }
}

//enum HTTPMethodType: String {
//    case get = "GET"
//    case head = "HEAD"
//    case post = "POST"
//    case put = "PUT"
//    case patch = "PATCH"
//    case delete = "DELETE"
//}
