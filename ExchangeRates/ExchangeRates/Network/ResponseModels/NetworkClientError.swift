import Foundation

enum NetworkClientError: Error {
    /// Ошибка создания запроса
    case request
    /// Ошибка сети - нет интернета или ресурс забанен
  case network
    /// Пустой ответ от сервера, при этом все ok
    case empty
    /// Ошибка сервера 40x, 50x, 60x и тп
    case service(_ code: Int)
    /// Ошибка десериализации данных
    case deserialize (_ error: Error)
}
