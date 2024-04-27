import Foundation

extension DateFormatter {
    static let DDMMYYYYHHMM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone.ReferenceType.default
        return formatter
    }()
}
